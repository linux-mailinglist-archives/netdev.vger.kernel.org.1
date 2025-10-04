Return-Path: <netdev+bounces-227854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C9CBB8CF2
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 13:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3115E3A99EE
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 11:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE5228CBC;
	Sat,  4 Oct 2025 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmQ7Hot2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A74014A09C
	for <netdev@vger.kernel.org>; Sat,  4 Oct 2025 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759578335; cv=none; b=AEv68M22RnUsnmsFzqC4viLSY5KUzZfafKJeR+dnAQ8WZ3/whxn08KNzMoX5NL9VJRIkvJo1VYDLun3lGGEem8BASPoE+yxDasyUT4A2knN4lo/lwBhHsAnhBDqJt8HRkR+cRdQ9ft5xkv8LSJUtDalEZ2R4ejnmaUtjaX3l0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759578335; c=relaxed/simple;
	bh=uLDk2OG5CoYAD8IAicYACisYmTIWk3ECt7xlbolSSC4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CJ2SVhn/+rchKRrEB1hx1B1XA1FQRYlEMdtQ8HyH43Kx8qfZsOhXsS1gJwEWdKIpA82bRWq8zR56xvKFup1SFZ28oQXWWZ+aynxCW6aMEefkwrxNM5IENTpMTAuZODsE0CSgWaNbV7X/lti+ZEMs7MbrpECf88QV6eXZrKMgASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmQ7Hot2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so225635a12.0
        for <netdev@vger.kernel.org>; Sat, 04 Oct 2025 04:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759578333; x=1760183133; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjoO0UAP8wLhOsBJOjJbYwG45v8R3yCdSlhLiVi5GKk=;
        b=BmQ7Hot2M1F1AGirrEpUOfk/YMvPZiG4qV98YvEe2WnB19/jhaFJcxyyjR5F6XLfim
         PKJta+Bhc7xLsijJy61BZ4uuz5SkrPhARQu87Tzhfcyh0BI6NBuyqXrvWc+7LBWofVq5
         ElxusasYvNGrC1CDKFk2+uzMVlyJlS8FtgrK4bOy7pVTuog+9ULTjf3uulC+uSrCAHyR
         QWilJtpJOfW3NHbCJEgbmtIYBL9UkyMoAeme+8d43+PuWMQVcRDM3ZG6xW/XKtxXjstS
         k0yuVCW88Gjzy1+PQrm+e3FlBmU3xVw+W6HiztM/lYC3AvzZP6jN2syTQFbFpJYLU04x
         uACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759578333; x=1760183133;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LjoO0UAP8wLhOsBJOjJbYwG45v8R3yCdSlhLiVi5GKk=;
        b=lHrsVwgSqWT0JnQ4xQO+jwzMIHRuTew74JcZcLG634RPuyq7/r2NZcNbJsII4m6tkW
         ylpX+I6fyKp4s7XolsTEyPACVsCkDPYEAcf1udgYKt5ATKgYN2gmbdJti7kWHf9EC1S5
         nw/YAu0jwp/SnORt03AQ05mOiicA61h4qfkQerWK3tpYaTS6y1lnCMGPL2qDpXiGnHN9
         dnZ8XHPyIoLmiRf7dhdko6Mv/jjJG2Vu91hEAn9CcjEvM6w5Jy/sKOyCnUL8E1xn2w3k
         pzt5CdY3lXvAHD6gJP2KsIQbdIaD426lDjYNawzypN4F3lbVi5W5Nts51Ng+YN3XOf44
         t4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUm9ypK05CfDmwMLoN1XeDvaKgUJRbuSVB5cbRcZ6f1dpTsoFxTlqerw1AiMBCLgO7b7DmX+6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3N2tS3UeWnx91w+/3GQifLwGaR8gqluAllzeWL87iX79jOiVy
	nY5ld82r1/QJuUHcZmMKAGWA7b9dv9wmlF7o63u5QLQ1GRy0wM8Dyfhr+kSLEpubxyo=
X-Gm-Gg: ASbGnct8H3ajM+bybnTmJIw7sQa/z7UXYSencKzW0mfSlh43rF8D8zoFm28sMB8J+3k
	ZH+HuUVBBjTSPn3htifWqQJ0U+uYwYmAXAM+ykzyLEVqi3ecplKDNx5NL8jFcxDyIJEyIZInZmg
	Fd6ov3rlnSSUeHzPZuP7pUt2D6gB3/54Gm1OBvVKcU2pfrzgXgmTVDLI8yZI0ieVUpp/cOTIX2h
	4P2w1hpYDNoU58LZ1B/vKCLWqUZGl3vdAi6CyxMbmdewsku/9NDhTpqQ+cVZkACmin9U1DpZ1KE
	AICeJfwoTnlOcVATIS55tZs4kiIKSLFsHFyK/AfuL0EnMFZ8JKL4FXTuYdHnIRhDTUAahQZqA9i
	3PF2SXJbfd10XA6XixBUFqQeyTPyzLvFQTlkfwRO2zpf/1cWROUg+pg==
X-Google-Smtp-Source: AGHT+IGwxuikndPwINebsmYQWlErDERFXYfdpKK/Vy/UR1eaJP/QxN4HgRPLWp92ywO3Mucwrrd+ug==
X-Received: by 2002:a17:903:1b25:b0:28e:756c:7082 with SMTP id d9443c01a7336-28e9a546d94mr75264205ad.15.1759578333361;
        Sat, 04 Oct 2025 04:45:33 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1269b8sm77029755ad.50.2025.10.04.04.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 04:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Oct 2025 20:45:29 +0900
Message-Id: <DD9IGL9UOYQO.2E59VYAPO8DLN@gmail.com>
Subject: Re: [PATCH net] net: dlink: use dev_kfree_skb_any instead of
 dev_kfree_skb
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251003022300.1105-1-yyyynoom@gmail.com>
 <20251003081729.GB2878334@horms.kernel.org>
 <DD8MONMKM9ZD.1PT79LGCA7U06@gmail.com>
 <20251004095421.GC3060232@horms.kernel.org>
In-Reply-To: <20251004095421.GC3060232@horms.kernel.org>

On Sat Oct 4, 2025 at 6:54 PM KST, Simon Horman wrote:
>
> Hi Yeounsu,
>
> Thanks for your detailed response.
I also appreciate your review :)
>
> I do think it would be useful to add something like this to the commit
> message:
>
>   Found by inspection.
>
After re-reading both your previous reply and my commit message, I can
see how question could arise. And I realize that I should have provided
a more convincing commit message, but I failed to do so.
Next time, I will make sure to include not only what you suggested but
also a more detailed commit message overall.

	Yeounsu Moon


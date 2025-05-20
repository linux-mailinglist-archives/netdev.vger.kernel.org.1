Return-Path: <netdev+bounces-191934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC1DABDFD1
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9148A4A3D20
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9319C1A83FB;
	Tue, 20 May 2025 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPPRsxfG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA224C068
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756894; cv=none; b=eiKkJoPYrP7cHsEc9QpjACPISdPdHu9g0+1n3yCoN5M9Ap1u07kvHQOw7ikOK7yqvmTMUzs/29kUvUmMmCYAU3H9f//BaSqhp7QPTaFfeFWNSWZWSg2jj0CHRKIl/dpDnEZ0bWnrNZ5TdzV0FljGK5qdilBmSWlZGreT5eGgOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756894; c=relaxed/simple;
	bh=3WpaFuqgemY1BfXOezocTpOIJJEL8+xHpHZQ8koRSXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOeo+e8Hyan2uhcsurC6bAyka8kh5voGxPziBRpeGzpuXvq5AQQ2chcGUUeVMm9lETgrCELARY+GKTdo164Du9kPNV0vq1z40aVJKGG5eHZK8J5hmdHRZjYfxw4yzde3dI28XbK33NRE/lSK5AJ6x6ymqOmkE6E5SZ970A9119s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPPRsxfG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2327aa24b25so11804475ad.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747756892; x=1748361692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WpaFuqgemY1BfXOezocTpOIJJEL8+xHpHZQ8koRSXw=;
        b=aPPRsxfGEK42xKeckAKww6jtdshoA+GB49m30/pvwzATZLTfVOpeGwv4MD2HAo+oZW
         F4Aqs1wNH3ftA6pFlJT0p2ny+wZ+JKIqEDWefMM6q9W2JaeOjSHccZmvucrKqb0LP9ES
         lOL6bsX9EU6Rx5kDd1FmkfK59UK3JYEzuxsPULiojtNm6iIbU0tzBaEylZy7kxh/0+gT
         vPrRxkcXOwuF6OYLabQQASgZNiyd+i2hobmJ7jvJlAVGZIzX5LfNYK+Yd9HAIylyfxUU
         rW07b77kE0z0C4dpIXu0fqXSDDj5dhhl7ntXs39h5ZytCdCM2u9HK+zETMfWfrykEWS9
         JYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747756892; x=1748361692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WpaFuqgemY1BfXOezocTpOIJJEL8+xHpHZQ8koRSXw=;
        b=t+MH67FKTxnSNgLLIhpKbql4H+ElscrX36Ye00U82RxcbHpqchHph6MqiepHISmjrt
         FJXC42g3xkjMFOcO4urWoYgv7OJk8kP7+y/4gy5YnSajqF7Cd9fvgqVkyR3DU/E/I85B
         TmXZuamHg618FWiOK0GSIxGMtNfTKaDAWty12+uzturmF8CWdWifqX24S5MPM7+pZXp4
         hklQD6JQjPQ0CU/i4GhF95IAjw2OgcMWwTskDOQXmCbZdfkQMlJuW+Y2Mwc28dHTEfIo
         p0xRoX4EYS+Sn6peOCY3GTG0OXGI4idzZwGBtuAk1aaBPYioc3i/cYoeYfkHhJXQNzXD
         B2GQ==
X-Gm-Message-State: AOJu0YxR6o1NBNUVJItgDObYs0moF/U5Db8I4gC9xpOtQpUxIK9fSkef
	SVzVCPEhKNRxL8z42kQdfYa+c1OA7QfZwQEIBYke0H3t1udKuVFsY7/Eia3FXLJL/kemnYMN6v/
	usLVAlxtGf1mnBxhDdPYkviBcQ6OKlRA=
X-Gm-Gg: ASbGncvIrZ9apbCLevPt+SSzNuuVE1jY7GfUIzkyjBaVIQ8igyDLPUDdFOOVRDVEXVJ
	LTEoRuCVHqn9qF98JbLYBkYG52Z2kRI2ECwpl+9NozhXML0APP45AmUJxKQPiK/pzwS5lq8r6+i
	O7EjrDlybsf/bI/xxpy6DZ6uhD88eyaA==
X-Google-Smtp-Source: AGHT+IGBH1wROnfvUVyYnKcCwE9Z+lQLbfXMTbrgjrcSVkVBcNUpFQrAkanYCFT/X0epMt9agpxILD1nlIhwqK2lv+4=
X-Received: by 2002:a17:903:17cb:b0:229:1cef:4c83 with SMTP id
 d9443c01a7336-231d438b415mr253288365ad.4.1747756892398; Tue, 20 May 2025
 09:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520050205.2778391-1-krikku@gmail.com> <20250520150619.GZ365796@horms.kernel.org>
In-Reply-To: <20250520150619.GZ365796@horms.kernel.org>
From: Krishna Kumar <krikku@gmail.com>
Date: Tue, 20 May 2025 21:30:55 +0530
X-Gm-Features: AX0GCFvi1brVT_3p0zQROenI-5ODUwpxDm7DR6RkuusjGvKEJNNvpz7Wu86dQHY
Message-ID: <CACLgkEYFH=L1EDTG2oVWM588DocZgnk_i04cgNsWT6A_MYD=ZQ@mail.gmail.com>
Subject: Re: [PATCH] net: ice: Perform accurate aRFS flow match
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, edumazet@google.com, 
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch, kuba@kernel.org, 
	pabeni@redhat.com, sridhar.samudrala@intel.com, ahmed.zaki@intel.com, 
	krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 8:36=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:

> Hi Krishna,
>
> As a fix if this should probably have a Fixes tag.

Thanks, Simon, for your feedback. I will make these and
the other suggested changes and resubmit.

Thanks,
- Krishna


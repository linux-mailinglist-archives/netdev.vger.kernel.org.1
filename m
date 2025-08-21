Return-Path: <netdev+bounces-215616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CCCB2F905
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C756178675
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E284321447;
	Thu, 21 Aug 2025 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5com0r5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAC7315779;
	Thu, 21 Aug 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780657; cv=none; b=CbHG92oTHcBEF7QMsHPGNsEbmJ5KtWEgkZVDJjvhtFnLtyE5s0SaHArEj7f047KQJBWv1Wzj0nEWBR1oY2zwCEn1AuuH5jLOeOAKVL5sCr291utYm3PUZn6asfwSZFrBD3brov4NQJLBkt6g1z0OwojyjL+6VI4Rn2xiZ/iEU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780657; c=relaxed/simple;
	bh=jGT8s5zSIKA+32oR2OuC9O7ATTgHr/3h4vyMVjynHOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYyYkILrqstP+ayRflD01Lfik/TWd7NFLlKbaFbWvmz94jfgamj4poMLGhn/fDpfsdGB2+sn+iiMUB4hPrdkJMKueJzxNcrnf5JuYJy2fliBvzC0BNWhbiqfBvAbSXpchrk/eJz/yBVUAFBMLpMvF1jWKWUhWNpLbKsEAWx0jcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5com0r5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-245f2a8fa81so13760905ad.0;
        Thu, 21 Aug 2025 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755780655; x=1756385455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9foK9Kd0CNIBHKg4DH+R7erYEYhgm3gn2u+8dPgiJQg=;
        b=D5com0r5Azq0CSiX6beJHOkXcRcyQEFGPikyr6x0h/Yq8uRWNznk1JvEdXWzIAFDSo
         YH3ld637J3MY8FRlfQNyb3v/WLLUqqhjTNX5VqiFSZpUs0WqCjuAWHwiEmLlZ28f5xQF
         9MBX12GJspK63wNbzVl+UTcrPvoH+/yoe7SuWjlgnS2Obbm+QyxibE062HdfhmUCPC7f
         FB8HGUTROSIyv4b/zL0JGhlwi6Ya4hlS3sUH2QiheQdWpcvsWyZlMfRVjWXOyY+5nRuO
         BKc0rwYMm2grpgnCz8K7klhDQcSpeYoMmRNplpF6/6Ly1Zm7mUzgsQFodyzJewbVEuYX
         CWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780655; x=1756385455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9foK9Kd0CNIBHKg4DH+R7erYEYhgm3gn2u+8dPgiJQg=;
        b=MkeA9YeTBVp4zmpqZqtVQCTzxEFL8VyKpGFyqHxq8A8doEhn73Wg21dicCkH5HJU8Y
         lIgPTAShTsFMBSQGYQ2bXV3BFGSt5wfRJdzMA2uFQ62+Fm8/+6LF346gPu7dKuDuMq08
         C3m9n4ITk7xzDmSuOewQwZk7cXHt2LPKBr5xouOgiutMUkJU0tzgZm6Jx0pcDRxe79Wv
         K8zaZ+RirvfdFSiGyoUkwlEBOpdAuRSahjtB64K6Cp8e47lE3KQkLelRiziFlvg4wz3m
         mfZAjdMoYzyp0wtdU3wybzzCRFfE7mhQ/cEsDtTJ1VAfWQ5OrWexPf0u62uVmi31HMM2
         nIfA==
X-Forwarded-Encrypted: i=1; AJvYcCVD2tZpn20bnQkovWJRgLmPaAzb30VWF3sQSJ+Zt2XbPwwn+rkX1v9TSphPfTCaeyQO9nWcZITFlEPj@vger.kernel.org, AJvYcCXEUBup9Jg1ScqrIzlbYCKR4e6/6N2gTSkQPABHo6VJYty4K95Q4zcl/D/+vyaUt2yQldrp3P5zIk7q6dCt@vger.kernel.org
X-Gm-Message-State: AOJu0YyzrFMvagaQk7sq1hYDKn5ox+d0uB2sNqe7KTnB/kRcDmlFnAGe
	mtcUpuwovG4Ga/DjSwiAqzh9OeACTSv3SUF0AT8w4sOMbaSt1Ij6yEJh2fWL6m4Oj4hQ8Ub+k/2
	m3dmSOUPv4UNfbbkQfCbvpUXlaDdwflg=
X-Gm-Gg: ASbGncvRMdjBe6kkez0fVzrmldBD7r66I4wNPmsPdjdyNdk7kKwFQQYxPO2nyh32GzB
	tKJx66hjafF6U2+tPet8JHs2++FQAbjXppjrHKrf51S00BWPL9WyYQRrurxeYqCqdrGZNY2/OqY
	6Ybr5730Dza40pnkQ7Z8JlpSkcnlctesCJxIFUgEhZNgQEFq57iRMJl35t7VYv1P9OQAibmj/T6
	fZF7pd+Ezgql9uf4KlqK1ky76Z3s/MchaFTw+t4
X-Google-Smtp-Source: AGHT+IFqVqOPssPGblynM3TvvWkBT6OODcOeZZiexLuzjkVsZq4nfaUJACCBtZMiYlZawr/SC4jDqihfyCN+1+16EOM=
X-Received: by 2002:a17:902:d4cd:b0:242:b138:8119 with SMTP id
 d9443c01a7336-246024c22f2mr26833665ad.26.1755780655118; Thu, 21 Aug 2025
 05:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820075420.1601068-1-mmyangfl@gmail.com> <20250820075420.1601068-2-mmyangfl@gmail.com>
 <ce66b757-f17d-458c-83f4-e8f2785c271c@lunn.ch>
In-Reply-To: <ce66b757-f17d-458c-83f4-e8f2785c271c@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Thu, 21 Aug 2025 20:50:18 +0800
X-Gm-Features: Ac12FXwwLwr2bCMna7pQhcpT1kCIgGZcsfwaI-LHJtYXN3OTqXnIVYFOWK6UbYw
Message-ID: <CAAXyoMMpf9u7aZO204moF5DHd+QR4aAxxdtEdTx-iU77DKhBDg@mail.gmail.com>
Subject: Re: [net-next v5 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm
 YT921x switch support
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 8:41=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +        switch@1d {
> > +            compatible =3D "motorcomm,yt9215";
> > +            /* default 0x1d, alternate 0x0 */
> > +            reg =3D <0x1d>;
>
> Just curious, what does alternative 0x0 mean? Does this switch have
> only one strapping pin for address, so it either uses address 0x1d or
> 0x0?
>
>         Andrew

Yes. I've seen this approach on other chips (offering two MDIO
phyaddrs), so this should be a common practice.


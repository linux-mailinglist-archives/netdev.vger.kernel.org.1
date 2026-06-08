Return-Path: <netdev+bounces-296394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YbTrMHJwJmoXWgIAu9opvQ
	(envelope-from <netdev+bounces-296394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:34:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B0365392B
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:34:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fairphone.com header.s=fair header.b=zXqWonrW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296394-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296394-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=fairphone.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C67BF3004410
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F637391E5F;
	Mon,  8 Jun 2026 07:33:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71F39099A
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:33:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904039; cv=none; b=CzSkLB0ZTKKLVCPVKJX0OZ0XngNOX/Odi2sxFfYVf97ALmL+CyxKqjLGE/nYNv01wUVPE2/TgGRyRIdhvFsbaVFO0NFi7MB/BU6xP7eWlH4ao0lzEzSnEztjqovgUjf5YzUFDpnnd1wxk4+lSHadl60NUMw5dUPyLBXfJ0iSy90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904039; c=relaxed/simple;
	bh=JZV3RuIjk7olDlPabOIdv/O8zwlGAlzLEmaLXcyKcLk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LhIcZ++vbaSDlo17P4bnur6ohLed4rB/l6N9rn+5vde7osM9DSjIxVc/YiRbiEIVHHFtxxmoIx3Jsa2WCiVYRJ/PFucLTOTbMUqeh2zHwzEPCr4nR/ZNzKTjyQH8P756zKQ56QlvKlU8eU1RZ/vBsWsEAA/rMUNwSo1W+D2/ViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zXqWonrW; arc=none smtp.client-ip=209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-beeba001887so506865666b.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1780904036; x=1781508836; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZV3RuIjk7olDlPabOIdv/O8zwlGAlzLEmaLXcyKcLk=;
        b=zXqWonrWFhauWO395Q9+0HIxwy4vwO+PkgEKGSBJ1qpZ1bh/XpORsolDvvzCSIAXQV
         gUnJRBUtelCcgqPdViQrVpbFb0SNlYumwjdWwxufnh1zbgg6W/0RotckB/ZtiA2UjMDR
         WE8U12rGibdjlyPDBrlyr+1/c9TOOlSXBEiwCCn4UxKtp4SWto0pfFfFDslBH6uKAo5R
         6mVJKPKmGI2wJwT6bwLQEQwmwF5zkAj3NOWtYwNkQ30frILx5J4D/6ZqTjemYVKew6MS
         gL4abfzJo0jsX0pBDpaO4kiKHplWefWimnG3emrWrb3zR/8EhLBbzFS/+OX43neTAl5/
         8LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780904036; x=1781508836;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZV3RuIjk7olDlPabOIdv/O8zwlGAlzLEmaLXcyKcLk=;
        b=ezUwYFxK0JlpDBOyT2fTJd5LcBYr+hohLmZfew0QXhieOqP2w9uvBmptmciVvlqnpv
         mTDez+eApfwN5pURGHib1wMbHX/U8Y5u0eZA79vB2PM4rXg9dGrYbdTTrJwW3enEHd1q
         XVSSHA8zYH5hm2o01nyq+AmZxeUzw5/rxG822x47hJF0K8oExn/pPJ5AnWRm4SWvzbNg
         nUHo4n4A8Oq10qyoqRhEsgSYAUqDhBnwp4JOZTdrtjTMK16B8O975hm38NziDLAj/WBX
         yhfFDisIf6vEJ97dWZPBie++C56PDriAUH2BTaay7UiYkHZ+EdK3euybg7iXvESRSRlP
         Zk+w==
X-Forwarded-Encrypted: i=1; AFNElJ9NBR5xnzcOPMSKylQ/xuWd80ViHkrmDtyATvM+K/r4UAE2hWe/JgyOpZsjglDaBAcIU1kX4l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0gVPEE54kw2S1ht9Ogo9AFCAugjFdsM4GTrGM3+b6weSUzgh
	3r7YrMjSLFjpW1m3J0xjzG40e3YRj8cONDBMGLsxzDan/yWEI079oZF79GN+/UULNEw=
X-Gm-Gg: Acq92OFG9x6Q5L8HUINNoUvF8kIzZAmhbL7cB8naKGet7vZ6P1VYsMYUqRgBGbA1zWr
	sq/kMXlFlys042RFpzVtj++8heXDo2ceH3QCclsGTpU1OStpD0wh4T4uy+qcgfiwQRzx2DZEX4a
	rPdfkAyUaoSPr2gBKH6UqcDA5xvryI/ix0e/rle+MIBnb/JoeWgwDURRidDZnWtr3wNJwrzjca8
	YJoWzobeUgkio1MOOPL1h92hPwtOWQgaD33H1rwP1OD+bg+KSh1YJRXvsS/rWFbkD176/7cfsBt
	LoQRUX+CMz7sQP2n35CF5mjZ40zvEsqmSbEjz7bboTgyWLAaTHmXu04fBmoAvLqXLvY3JOG6uAx
	sAt4zLvfGZ6f21gIpLpcIhteqbRjLkr43BXdHIKr5nv0cBZK6qv25CJp3lWxAyV/IBDvAC6TAkr
	oOo0HRp3X6hr0+lyxa3lo8oWkTBqIEqRhFFucDru0eJjQDQV8dmhJboVTei58CBRqGpih+XUSXZ
	cRdlWU=
X-Received: by 2002:a17:907:6c0f:b0:bcc:e8f:c3a8 with SMTP id a640c23a62f3a-bf3738f1e4amr638949766b.29.1780904035800;
        Mon, 08 Jun 2026 00:33:55 -0700 (PDT)
Received: from localhost (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0522834dbsm815190666b.27.2026.06.08.00.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 00:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 09:33:55 +0200
Message-Id: <DJ3HSJ8UK5MN.3FWLDU8CG2J2R@fairphone.com>
Cc: "Ajit Pandey" <ajit.pandey@oss.qualcomm.com>, "Imran Shaik"
 <imran.shaik@oss.qualcomm.com>, "Jagadeesh Kona"
 <jagadeesh.kona@oss.qualcomm.com>, <linux-arm-msm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: Add GP M/N clock controller node
 for SA8775P and QCS8300
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Taniya Das" <taniya.das@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney" <bmasney@redhat.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Linus Walleij"
 <linusw@kernel.org>, "Richard Cochran" <richardcochran@gmail.com>, "Konrad
 Dybcio" <konradybcio@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
 <20260602-pdm_clk_gp_mnd_v1-v1-5-1522662b6c53@oss.qualcomm.com>
In-Reply-To: <20260602-pdm_clk_gp_mnd_v1-v1-5-1522662b6c53@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,baylibre.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296394-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ajit.pandey@oss.qualcomm.com,m:imran.shaik@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:netdev@vger.kernel.org,m:taniya.das@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linusw@kernel.org,m:richardcochran@gmail.com,m:konradybcio@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[fairphone.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0B0365392B

On Tue Jun 2, 2026 at 5:21 PM CEST, Taniya Das wrote:
> Add the GP M/N divider clock controller node at 0x088d3000 to the
> SA8775P (kodiak, lemans) and QCS8300 (monaco) SoC device trees.

forgot this in the previous email, another kodiak=3D=3Dsc7280

Regards
Luca

>
> The node uses the qcom,clk-gp-mnd compatible, is clocked by the PDM
> XO4 and AHB clocks from GCC, and exposes a single clock output
> (gp_mn_clk) on the dedicated gp_mn pin mux function. The XO4 clock
> is pre-assigned to 4.8 MHz (XO/4).
>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---


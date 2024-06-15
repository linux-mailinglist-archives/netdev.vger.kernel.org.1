Return-Path: <netdev+bounces-103800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96349098C1
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 17:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77681B217F4
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997A49632;
	Sat, 15 Jun 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aOUuiSm3"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC74779F;
	Sat, 15 Jun 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718464352; cv=none; b=ojOzV260F1NCvNAx+JGo2c6xTqVGoxl2+YLNmY/ikeX7J5BgsGeUjdJiwDnb5ER41X+hs2S8fKIyVXJmhyM7grTu/BWtQsfiGdzNwHhRADo49AqtDCeKg3mo+l1OXrm9ezTlF5C8gmzxJMmbhGLBrUyznbls0WrIB3k/kFUhkmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718464352; c=relaxed/simple;
	bh=HrTH+jnMarRydEt0XzI1AfUq6mBxW16xbyAhgzSLLpE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jl88y5U60beCRrPu/hZtPTG0I8HL7dsReWDRP/A6eTEEP9I7J2VI25R2dhsIYKmVFAqwYXegBX9rJndDwIT1lwS5Q+ipxlcofwUedaQRePozUU8+65FhL8zvZNq04sH+p7EHkCpw0MbtrxM1noDLAIiPId3W7IHQPFD1FuFN7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aOUuiSm3; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718464326; x=1719069126; i=markus.elfring@web.de;
	bh=xI4JZOaAmekL9oFIfzaMYWl6BzblZDDLaeHSkSLoktk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aOUuiSm3d/ShEPw1JJveglmyb6Ub8y/eL1t/xe8KB415X3pDRgj1JyCYUQ9R7Auz
	 ObdQ8CsiwP1xth7XxRRXowvsB262EOdPxlbqRkyLEUJfj75lC8VE2DhIhyQC8TQRm
	 rXC0QMDt1s93H1zzZPrf/5w172Uv/7ahhM1x1eAo1EtRY+ETd4kmFsJjseUz4mDj2
	 pYUspWTfNdNVd1m1rxB8aM4rtw4S/lOR6lSG362SdraUDxDcoAnFw34ThENxBxi36
	 VJ/gw0x9D67wtsMusvdA5OrM9gQAG3XquNcjoJjXrw0L7YZ4u4YYR9JLth4TQwHGT
	 q/88nXqZ1rV14E6rxA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MActe-1s7SSk1RFY-000PnQ; Sat, 15
 Jun 2024 17:12:06 +0200
Message-ID: <ac47a370-99ca-4fb9-8fb0-800894d04c57@web.de>
Date: Sat, 15 Jun 2024 17:11:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Hariprasad Kelam
 <hkelam@marvell.com>, Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
References: <20240611162213.22213-3-gakula@marvell.com>
Subject: Re: [net-next PATCH v5 02/10] octeontx2-pf: RVU representor driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240611162213.22213-3-gakula@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R1B6N0WVGY1VQp+C75jxqiZVbMCFo8atqZM/QFi0wpeKIIMGZIj
 u8xrhKg7C5xMzaso3wGtA2bR2T+1MbfXVnhuq910wUqUGCfqTkbqZVyrP/wVSWtgNpPRPDF
 nrXTtmHeJwg0n/J59qPKaa24c1577821ET2pWeAqSRspmKER0UeDeu66Tcs51eygQ4eFnuC
 jXkl5ZJWn612x70qwWalQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yAljG0BDJiQ=;ezgkplc3NxtvGdIWrHfSknVEaQU
 YqyGLMGqb9EjFAnUDPDtHpsGQsDdunW0qQqYY/GWrkTbq+quoCUy9FHo8VEaF9Q+pU4JJWNBk
 6aHjY9lFCs1y5P6M1TI5RR9u8srzxL7cYIdNgaE2DxsXOsfATWJe14d+PMKaHyqzR70Z2hkxJ
 mqQpUIhGxfQfab79cBiozsoyEGpYtLOqqdng5zkfxICezCAfcizrJYvyXNn/LZ1MomOHogcKy
 QJgnD7KeGDK3+AVv3R7R34B/oiJ9UB3A5jWqOOkyEqrGgDJE5oCquJgiXSaSzuEfu1CgMUqu3
 Tm7wWsOAWZWlZnvvF/8LMBnDE+gRyNy5LXhChx2Kt5Fo97am8j0SOXOUUIQDqdNbrwWic+7MC
 wtofcn8vu625IcvRisVZYhABWY6dym9qeGbUBCGKH5f7t00D5FCMdHzWev9aoOLbIYzpXqM/r
 lv9ye8cvhGajhPAsqE3RRYCc1Phpk7mgV+P/0SFMAnkAHqHB6tsWs7/kjJoTqJuuuuGRKuGth
 w3qlUCyiFc0X2UNneNXIL4GnV4s94+74w+H9AgGtkZjpJIpCpM5DDuVIZkYQAarqH458EWBxt
 lXWjLrhmLjkmSRi8ncpmpkDZJ4AolpSYcrkLO+bYJIUlRynNe+8IuATfTKvbaGswHscRO1/To
 c9Y69ih73KkikrRHV53d4ydqtwPohziskk0eAjXY5BEhvrxDE1+JcobUWOuvmJUxGoGJ4qRwE
 mnr10i2lk40mV8tOSLrz7C91AIPqF3zq5HSv7hm5whbaqvGgzg0c0v7FeX3tLLY0TCzXwK1Ym
 4ef0Ph73u8guAkyJCDUjv/7zIOx8gDAKL/1dnDsl8tD1c=

> This patch adds basic driver for the RVU representor.
=E2=80=A6

Please improve such a change description with imperative wordings.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc3#n94

Can an adjusted summary phrase become also a bit more helpful?
https://elixir.bootlin.com/linux/v6.10-rc3/source/Documentation/process/ma=
intainer-tip.rst#L124


=E2=80=A6
> +static int rvu_get_rep_cnt(struct otx2_nic *priv)
> +{
=E2=80=A6
> +	mutex_lock(&priv->mbox.lock);
> +	req =3D otx2_mbox_alloc_msg_get_rep_cnt(&priv->mbox);
=E2=80=A6
> +exit:
> +	mutex_unlock(&priv->mbox.lock);
> +	return err;
> +}
=E2=80=A6

Would you become interested to apply a statement like =E2=80=9Cguard(mutex=
)(&priv->mbox.lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/mutex.h#L1=
96


=E2=80=A6
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> @@ -0,0 +1,31 @@
=E2=80=A6
> +#ifndef REP_H
> +#define REP_H
=E2=80=A6

Can unique include guards be more desirable also for this software?

Regards,
Markus


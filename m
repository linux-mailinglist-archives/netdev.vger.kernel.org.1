Return-Path: <netdev+bounces-293326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFnqFqnAGmp88AgAu9opvQ
	(envelope-from <netdev+bounces-293326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:49:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA7260C3D2
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 774DF300A64F
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D15397B0B;
	Sat, 30 May 2026 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b="pJ32W0BM"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78E2FE074;
	Sat, 30 May 2026 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138146; cv=none; b=B1DF3GI8iNV7/w89+GOD2yuqgkjCcusqjGCgVyzbdS8vvcAPw4/o8hoqZmkLHcxr32SEXBDQj1bBiEJcfOXFb5sjA+HMvy6d0K7nDT8fh/xViAmBW4liw5imDCKQuxg7biFSA4LYXBrC4WD3uN41/tmEZYFFlj6f+5A6X9Xn/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138146; c=relaxed/simple;
	bh=TOvPRcx4BB/kzuG/vXQv/BX1d0ZZg4FjDp5X7NSHdHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcZn7IQIWMPyIKIc9+xpbynq6tBJKp5xcV8MbH4JQ+quNNPwrn+oS+abnq6mcConDqK8q7DhAyPxK9NAFMa45SwBHMus1rIHZ+YXo5r24L0glvUOqkVLDivoEi1Jt52sF4Gilv7h9LtmZtMQ1HYDGmcHtVnzzJ0WdEo/xoOPHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us; spf=pass smtp.mailfrom=gmx.us; dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b=pJ32W0BM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.us;
	s=s31663417; t=1780138139; x=1780742939; i=len.bao@gmx.us;
	bh=ss+PN/KJJeYYam4sPM7UMpBKgZQI7xhj6S2/PtHk44A=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pJ32W0BMDGyu3DMcLG5ZzyLq1hbRHVyysycJrhJH3fr0M4/uBrOaH4Psr7cGrgdF
	 Wt08K0b3y7GveR9wG+yKx3TkPF7vk2nOsQW9Tl8KJqIIvca4kCQBLkjdTSj+m8VO4
	 /CcXj/kzr022vaMUjtllUOyy1nG/PAxqY4dilxOB1bEdnYJA+TgQnNi7VTPqjl5ur
	 1LF5Luq+0vknRpIydg+bK0NXijX9zgyjvizGE49j2D4d6YRnN1jlRGx4D8SbaGmSa
	 BMahaUxdrjME4xtSh+8SDBgEJZT+5XR4hxXLy0Z+PbRkcowMmaKFLCebxln8m2cTr
	 0jqYu24AHczQG9K9kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N17YY-1xPxiK2hHm-014uaT; Sat, 30
 May 2026 12:48:59 +0200
Date: Sat, 30 May 2026 10:48:53 +0000
From: Len Bao <len.bao@gmx.us>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Len Bao <len.bao@gmx.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eth: dpaa2: constify dpaa2_ethtool_stats and
 dpaa2_ethtool_extras
Message-ID: <ahrAlZSp3QnLU636@ubuntu>
References: <20260523150737.36988-1-len.bao@gmx.us>
 <ct5fwlsotsgvfjazc3vp4djj7hyi5ix7kreyqf4hohi5537plb@ehqkkzl22vcf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ct5fwlsotsgvfjazc3vp4djj7hyi5ix7kreyqf4hohi5537plb@ehqkkzl22vcf>
X-Provags-ID: V03:K1:htZb1DO8ta0Xn/rVhvsJGyUxYh0rkZoNBmLZPBjdVblKendubwO
 iIv1JOWMsUHwncp/5Hf00bZW4tsn+CiyVsQIAqjeXD62IJxHUpup2K/IM6n7eIuir1m2HBG
 qtRWa8EYH5accqATxrPOVG99bkcxHg0oRwU7+Ld83zrqr6NPxJVOooe9htgv22aisU21rjC
 jahnkuvh+QkLg2xFZn4yA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QtN9BOGX2YI=;MxJp488wzClnuxfQ4QhcGbdTnkj
 7kxP+gt27jzZmAy7ZZ712QNMRpv31DFikHmMvRCLKLgwG15o26v3pODMCvMjgzzQSO+w8r4WM
 Xp5LXf256zDkJ6BR/9GzbpV5LxTvO2EY0Luu4XQfgSocrxgPC5YcUhMmKXDjW7meDmoDn3JFA
 1P+V2777ZQT+4txjGclxFIz0bqOZXfcOPpRVd2SKVPjEpckY7GAdSAg0svtYgXv+ZTha7ktV8
 KJf3Mpu5PQXBiKcMZ6Ji1/WlDQ8qRDuwQ4KkQuGdfb54vp7J8GuvWvwTg9yURMTEfJixsYXol
 vcc4h661HDNoJdY0Oihw5CgDSCdaujn5UWCH/CUVdYUaSGLrqt3yd1fD/CA8CVZ26zVPp6C/x
 GnvXowUqSTuX9YjDrbnnd2fAq/bQLpUwdCo5w7TbJwIez8xtOwtRHiVPwVMWG8sZFHBnMIJFB
 NFCmeFpAPi13AY18fzE03u0+6h5ZNXsIMybfDKQY8TgFz7JHhHPXwy0B4CusKvAuFw3zjoVfD
 95G1tdnhu8ttjSvfFaOOaQy5gQYBYZtZbU5t0tCs1o29jE898epu572zcza7Wc+1OMpReOGoL
 PzTv6prTJYOzFsSxNDSCtQrlj9ilZxXBTDuPr3frqiZQT04wLZVVc2/iA8tnrMJ6VW60nSUy4
 XTg/nCjrMkBIFhVJecMbebDfa7KC+Z/2plKwa4FQnlDCaJV9EW1kpylRo016s9LQsdy5lV+eb
 KcactG43FwVfHkmkbtk1+dCCtm0Eqm9p/qJzYqjBsoOgneyFFioa/D/V15TCFz9V0FIlPXD/f
 +gka6GKYB/YYDERDM4fXpSxhDoZr3nY7Oad3I/vQomIw6QshSWN3E1TrpvoENlG42u3TcgzwY
 d1SbFRVdZuMmXVq0pCjKFUv7eVakHUBE1huJOrK2lzXMMf5rn8uq2CXszRYJdkHdFQpOKuw9b
 peO2XMNJQY0GZbrve2+FzC3dlEDi8a0Yxp7RTNUpKQEyZYvFtCIgq/R6rwssFCt5azBTailAZ
 sTWwtWlkNFZzaPZjnXSxHYuRq30FFU985BLAXNJ9F0uHAVqTIIf+G8LGlfxm/B0L39KMFaMvv
 GMqCCJyurDGwOUFf5rWEArhgpL/8+V/evkUBNqGNbWRnFotGakuCx46y3WYBflwq3Z8DdmKT7
 AuTNXPdsEvbAqEzKDto14LZS8X2t4ZRgmFLBp227nIrOtfjx78hapTZ/ivQS3Ld27l1ziMwQd
 Jy63ftxd/bALHph5Q+xPv6byuqwmCPYBYDrY8lyvSSX9UnDoEObZJyAS1dPRvsghXrLltMELe
 SbHvrrrEF6AgygAhouoLbG9YDF2FTtL8PnpAyDqOOTXCFspCkiN7Waa/ZAVcd+fzo70IhXh+W
 8ujpihiHtwH6YZOhOcvIef9B5OqYqMco8xew4kd8CzTOydQ9TfHxGkoiGEkRpmWBNFd5y3xGn
 Aq6xwTak7Du3aGsd2y81GH7ptXvuxODYlLdtnbwXZIx5vjYZlx0mgL9R60VWml8FuSV2sjvC4
 Iom0ZquYH/cRUI4vpNY3UWdr7ko20+KNmLQtmVCfgNXFAeL0Sa1nn/jHHIWbBtFbIUDZAMZt9
 8NzG0vy4CK0lZW2WZI3caPwk6RkY70gAKHJ/g2dmtk49R+ka4xfU74pEcBz5/bJYJ3A+5zFOm
 Ix2G9ZB0t2XRaL/KUm2E+vSDaKbeWK8We2kqLPByVnzC6dcB6j6GwOFjqI7fKQnsrANZMTr2x
 c5HqoSn2WEL4At78rzFgkK2lrtGLPrhdbNCZqyPNLQiGJJAbqOZoDoetM0nd4I+r1BS0nVDa4
 GEhS2joXx+/IOm/BaXgXat8Q6ofe73h+6QSAkS7PqurEy587ZhhVFNGP7iMJCchNS74DlkO1x
 jgqHwyD31MbOoCBpJP7KEXOr1/BjHqinlQeLFk12+EVNVA1VuQmHj18v07SYzCxcfHI6HV8bz
 vmJSNUcQoZdMZnQNZ8dHVOYWeXHPYZHV0HIe+EOW1LeJrx17USsxVEft0mLB8igPxRbv3FAcZ
 RluR7d4Tz3obdhHA8JsYAd2YI0ljIX9SuKCrmJeAj+OhGSsK5utNbrex9TAeWhO6KsRsWBVMc
 tdy/vgQhUn65Ib677UKXhGgNGXclVs7/7vI+k012zd9yBt8wx62XzOPffrwXHUOB0sxKi+twV
 YyJ07bA/A0pc0HZkVELWb0cafkjA3TOWSLc25j1x80dL861GbOQYM90u/e1FN/qazdL3TabfZ
 SmeRDaapQYYGN64ool7cLMsDGnGoWnl7uMtrRp+nFSGKeitEkB+U4gKsfOqT6U0cFcUDWfBuz
 pz5BbbdvFczUhwmpI2JdM41IBGmU1Sjlck3lvYSdnYJXrRUp84Kg2RJ0C5wEslam5gQ2bN6mo
 RMMny3pxqxtvJJI9PyRUgsdkls2zF3H4ZS55W9AZdBy7DaSxf7vu0h6VGCI+kyDoVS0f4yToh
 FLKmWOsV0oWtclfQrSEeKtX02HRK14UiBKG5yKTia1+pVK884HI23pNncL1aIGH0FqvwkHog+
 U+tdJeskFyIAN2vyPUo/3IAOJQ4S6nM1lrhchdMVo+7nxw/iG5WqQ+Xlj3xbCgCxgV100kG0M
 eWbYyE76oThI5VsKBkxwehA7V5PWBdibA78ShHYoJBNc5YcFJdLqARj13ZZyY3xw8xK06+oTY
 2Yvx5sO4d8trX35/RfZmlZ/9OEWE+pd5wKZNjUHgU9VNzaJY1YPxMSPmKuQS+XyZnsn7wKt0v
 KNwhx9Q1oZhk0hwOgytwdfA3n1TVhuGNZ2vs3BG6fxKXQcEGbLovB2hWrBLflB4kW2PuzB/4d
 HPPxTCpIrrS/3V5pcXSE1KigGBGbmRrL4DhfGDwkQkq4yRdWOOCISgUQw/ak0HlqIiFEYbdBX
 Fak3JYy5PkVNLYJcrVZoUOPfNGAlsrgg0Cnd7Q5dcoxdSsLcTPYSEKWEAlq+87nh+I1RDUWAG
 xPTgIfWBgIamlY1u0h5bZgKxWaJbrTysAxGHjzwY+XgvyZMkQk2J36tFDJbi1g9U7AvQqbnHX
 VvtSV4UjjpzbJNPPusB3pmJrN+qzab1BkoOH21MeddgMO7ZvtIlnsDjDUVKSyyztbG8RWE6yN
 W8w7OrZNFj6Mdjf4ki4RLC9y0YezDgvEBOZAi0JbU7WdzCUfqKb/gvCPwDhUaZzWmKJg7sZ0+
 /zWSbIOMYZBqH+8zJPnlgIQgltBwRd2IdOs68HcKsoQBeUNl1sJll4iLZqTOfNNOswwph40VL
 q/F5hiYseBxJHE3ZephFSpSDSm5BRXnsyfcm/ybRgk4syxPDkDx5nw8/guVqoHKyaA6ly5/zv
 P27DmX03/ecrNMo6kPNUvjI5k4EfXb7xp+eogFLM/hynvoQAGvHOCSMnbD/tU2mnmzmBU6ifN
 +OmaedB1ueP3XJEo2LmiAU/U/JxMm8tYJqYTMjXyvE606Mo9MtkDCocebiIlfaTo1RzGohZUO
 pGxFzVKBlEarh6eWoOl3T7DfRZflGfANrUSmEzQURygLaYs6n2SfHBbQ8/C2jYglAeO35EPlX
 N8l59oQG1owKepbWTf18LFA2jLthjnzM/Ymexy43i05uQpRdnsD05ll98xz6gZo0b2ZeIyWI8
 jgMPZE60J8eGOxPv9syT5Eir0DDPua56Iuh7KOznjbE7qqSKfrPiiTiNC/w6y2vp47nYT9Zbx
 r4lReZRq1+e7eL73a5p54aMvB8ojyHztqQ4hUT63YTcLVExloWSyeF3t8dNLFOQWT09ehL/qa
 1BWvyvheiisOwAMXCQb+QtuULQVlJtom0ZDXc1sTjmFJJgBMFXZcomniZNNXjJAGcQ5C3Dm7I
 fE3Ku/uczHwkCIcGTnSyVPygJQWSTBtIlGYhTW0tYNlck0CSu9KCc1kxlNoNcUcSYPU1yKwkD
 vpU7OdEDmN5iFgaCIs9Mbze7XyH1DjgFNYnxT6v3h5VF3GhaT5ioSC0KK2CiBdZIGIR7dxbkb
 U9Oc7hGTgDJRV4jW4/hQdUM+WzfU+89VXfDqHXO+O+Bfqhn0XEjzK62iEqT9KdQ7LpXbZD7ky
 rHK/8oluvGc5n6xdvDcImWqW2I35DGGKL/OeGyCNF/gVQ8NqeHVjrgsRapXB6CinWcWI1hRN3
 uudj0ILDgqT2JVO7dY8HXEMxH4Q+ErCG6wy5RiYFvGew1nvBgr6D4XL/zA0CVX+JTrWzoWyOh
 X1UfobV8l7ShffqyEPchHUJl9puWdBswob2GetEB8UsQWlX4QiAiBCoD3rn2zZpHZ3bEBfDf1
 +NDgH+TcN93fVpl2LaMrKvuqPckIdzD1TWR4LPEhrz12wEUO1cDngaHr+fofCSSFVI2PrMAko
 ehu0Et9qu6gxQoojGeA8ZofRS8anrmpUHHwpgzAd7AsaosOTov0LTJc3JIlGXglsKq8wmBI99
 lvuF0h9U844gPhEpE2iY/2eiiy9w1xPiT+KDr9zODMHeEXQwrmhaufQB0idHm5GZeHrIrl1Cu
 CZmOxEH3W+gW7zEr5jGopaK8MytkB6spdCZRAIAnKQJ6M3KSEJ9fujf2ves4eMBGlRfuPMQss
 /w+xq3PZhDnYhxzJz+ao6RrkBEPircTM6fKcMpk6WlqH2GUBvYdEpK0u+Yd+YzzJYSFpeM+oq
 kqKWqAkVhLqnTNMk0XXVBIDHiMscstP4//Kr1zby3QjOvdEgsIKuEVLe+tkWyJDXtQE8b3jCh
 IMebU4rvWfJOpRRwI4JIMLNRN8KzchPoBD/twqo5EElsdyVhO3dU98hjPX1WnNt4mgryn5swd
 cOu/WG9Alg3P69VfHqs9iAymuupAROYLgUphEwh99BySFTY1i/zK49ZO2qvNlTd/q7sD7I8gR
 AxvJGht3oxWKJ2l87wQPJZ4C65YQSsD3cYYSstOQ3g7BOeP7qISLVz5oPIVqCBNN1awhmExpi
 2cU8bv/GUPYkAbnnJK0W8TMWwdHI3clkrOFkpny4LWW1PO1zXQJGPlS98dqDURl3npyLFTBrW
 cHhzKl7IiUL+tKH49k0bdoSOTCxMKRmUYXB9kv+yqp+XqJ3HQFh+XMwK2nrwaKFCe2zTrOtKj
 OjnFf5gOUiFic1PkYWvGk7c0jS5ZvFGXlFgeL/Anp+tfQHVX+LfAIrhl8PnrEX9UFFLMT8eYV
 LCTqsJXUFz182y9d85XL1zA4JV5f1WL7WVrE9D/lbibotFyo8lQ0BdVM23SZibxD9Qa5JmtoW
 V3BnBwIkDVo2mQSb0e4wkh+19h7kdAOvPMFsJ/ACfEeXBQMx/3O2mpIgX8UQ0NKVhRTzclybV
 n+28t81LjYY7fzrxTuMrbrUvBr8aJcL+G3CWKIBBR0ADj5pWFblxhKUvzRBZapVn2m7ZBrDGf
 q7ikDTmA9eS7xluGcSz1T4qheSlimESltIG4a45YZQG6EZhP0ELSA+5nnIrFOAgWYmt8M+j1Q
 dkrXorfKBeuBIZU0bXlPHdJ7jiZubUIQmQuy9yWnznLRTpcAZRi2mefDUhP5UQo/dqOw4gIEz
 iy9dXavcvosHWIsO6Xt7dhOGIt+9yHJPpxUTx8O5zoa6jfXQ3d/sgrtLUR4tfs6cqvq5XtDCT
 SDFAMDOqjM1+v/CeuST5LAr1N4MGXibkbJRealVpJ+eMm6sv
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.us,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmx.us:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293326-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmx.us,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.us];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[len.bao@gmx.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.us:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gmx.us:email,gmx.us:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 5DA7260C3D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ioana,

On Mon, May 25, 2026 at 05:40:46PM +0300, Ioana Ciornei wrote:
> On Sat, May 23, 2026 at 03:07:35PM +0000, Len Bao wrote:
> > The 'dpaa2_ethtool_stats' and 'dpaa2_ethtool_extras' structures are
> > initialized in their declarations and never changed. So, constify them
> > to reduce the attack surface.
> >=20
> > Before the patch (size dpaa2-ethtool.o):
> >=20
> >    text	   data	    bss	    dec	    hex
> >   33433	   5992	      0	  39425	   9a01
> >=20
> > After the patch (size dpaa2-ethtool.o):
> >=20
> >    text	   data	    bss	    dec	    hex
> >   34937	   4488	      0	  39425	   9a01
> >=20
> > Signed-off-by: Len Bao <len.bao@gmx.us>
>=20
> Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks for the review.

> Next time, please mention the target tree name in the subject prefix. In
> this case, it would have been net-next.

Ok, next time I will do what you suggest. Thank you for the guidance.

Regards,
Len


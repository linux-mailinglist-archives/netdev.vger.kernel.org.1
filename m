Return-Path: <netdev+bounces-228210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E3FBC4C48
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 14:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43353C0E77
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 12:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF123C4FF;
	Wed,  8 Oct 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="k/nuk2hb"
X-Original-To: netdev@vger.kernel.org
Received: from out4.tophost.ch (out4.tophost.ch [46.232.182.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473FB21B9C0;
	Wed,  8 Oct 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926511; cv=none; b=Y9H0RaQVK8z/4H1TzDaRwoIOB/M0uA1GSqvKkxjCvKiMw1UsCBhP8C7jclwsf1OYkB3qt/1nz8ti8uwcBCrSzCFoFTgT+xAUVQXIg1qQi1OejfVHnqkmLGZHU3nWijBk3bpbg1sisy/C5CO3CDc/mxnt6K7ve0Te5N2E8a6eQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926511; c=relaxed/simple;
	bh=bJZwQB0eD/a80IPP/m1ic8+FM4WfH8rPsVolRrikLtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIhR5MXafh2USq3PLWEH97X7bTbo4CMbf+FBFpJzVaLAtXh37JdbYrXavy0QJkTUKUfKw/LM/TQAs6QnQwxg6m/ngVbC112kRNexUPlyq0N7HL9FdFQji58hjbJdtJmLNxM+5jbD2TZUluGpudpSeA/GLsHxD/aR95c/FPu6PyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=k/nuk2hb; arc=none smtp.client-ip=46.232.182.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter3.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v6Siu-00HEio-1b; Wed, 08 Oct 2025 13:52:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jcrzgQaRo1s3Zc3rxVMNCH6Ga4jTLLoMlb1z0pI42TQ=; b=k/nuk2hb22e48eTiuOitgKNYnS
	S6S+PxKSnOb0A/DjeNt+6wofSRKNGY34A2/XEAUq7QqQ5VyV7pTUL7GG6thx3tJYXEQit2zcHyCRL
	8QswE0ABV3qgGyxpQVVcGImMHl3V5GbTnfyTrF20eaGHSTra+SGREiZascklXWkK3J3xN9drEEPs9
	F9MNvA+UIeV1V888hTDQSyQ6Xe4fiu5y6FuaMMU13f1mlXMdsOd2hgFdilNgPtHBtPO7EAyYY7hhY
	Cs0x9+sLanO4DYTP6Pjoh1Zw+M7VSHmLiVGUmo5lDoW/B7dhjev0EOEr+5QuoNiWBRa1zVkAF2zXG
	FZwk7zfA==;
Received: from [213.55.186.58] (port=20306 helo=pavilion)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v6Sit-00000004Xlh-0ZFe;
	Wed, 08 Oct 2025 13:52:45 +0200
Date: Wed, 8 Oct 2025 13:52:43 +0200
From: Thomas Wismer <thomas@wismer.xyz>
To: Conor Dooley <conor@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Wismer <thomas.wismer@scs.ch>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
Message-ID: <20251008135243.22a908ec@pavilion>
In-Reply-To: <20251007-stipulate-replace-1be954b0e7d2@spud>
References: <20251004180351.118779-2-thomas@wismer.xyz>
	<20251004180351.118779-8-thomas@wismer.xyz>
	<20251007-stipulate-replace-1be954b0e7d2@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Get-Message-Sender-Via: srv125.tophost.ch: authenticated_id: thomas@wismer.xyz
X-Authenticated-Sender: srv125.tophost.ch: thomas@wismer.xyz
X-Spampanel-Domain: smtpout.tophost.ch
X-Spampanel-Username: 194.150.248.5
Authentication-Results: tophost.ch; auth=pass smtp.auth=194.150.248.5@smtpout.tophost.ch
X-Spampanel-Outgoing-Class: unsure
X-Spampanel-Outgoing-Evidence: Combined (0.50)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuV5syPzpWv16mXo6WqDDpKEChjzQ3JIZVFF
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zEtV
 5r/L4Ot8UddBJecz0vF0xYCHwzEoZpUBagq+YQPMCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYsG4jVZi5Tfop5qjCZejidXzthz0vNkOX8Em4cj6D/wddIY3ooDH3xmALJ0KCcsszI9W7vD
 6C469DIPe8wH3iOJ3xyMg3et4b3PQUopDmbZCssYHNuxAmlPRpR5yzngsxCROUzReCS8EpKh0It9
 L25JS816nuiE0t5pG6MLXGczoaQ34/6XxaNTDAhv7aV57JsPc1xQig4or8SGp+oEgVY8m5YhXjt1
 1mZXDl6SZZzjGdqG2Lj5rCXX7a7k66n+dqZH8SumKJ6G2ITZ1QpN+fKl6MqQzpHx+R/se4ridaNZ
 B8TZI7fFfQwiuwD2LcLdqjNzWvfUWpSzeqsU5PCGCDUFaU8uhHiAnATVZ6fUz0ieq3c+galx1KGI
 Pp5jnkiI48QcVV/sevQbkxCuiwh6Dw2ezHpzBWCNEjuWRvIT4EJ2lr2fnvN0vyHJPWrtFePT1LWJ
 YkjVkiWyun89aYjOQVn+0u9hv6vc4kaDyrzZqOtFmCYx9ZUW4uF3IsCR4FQZzMS1+iCTTpBSBU9f
 +Vf3ILgJPePj0AiYMnkOYZl+Ft134+Tg4Kc9J0hnMXKx8pjHWEGHlWxPsl3WEfCK++QP7hwqRAUa
 ZyvXYsGqun+gsnRrwx4NiFDSlcM+Wn9owyaX/KlLn/njN5eSj526f3kLYY1TsMEeeHi+U6STQXMQ
 D692EpmpxHPQ6fdixDnE+NhRq2DzlcAJUjaLcRLsWJVw5FAS+DG0fESebuRosX/9DvJ1PqhoyZO+
 55MGpfuy7J6qK9cOuNFQ+5eGIII/qgXB3gv2NI/ukWuQBNrXV+EmIqM8SxKOhcObZXWnkEw+6F9C
 GyYaSNdYCqWjx7tVBcUyWD6tuli72Uhh4KMdzekambyQyMd4zC4QeDwRSaOU1duojVsD0mcRXp3i
 H/O1nLlsNVT2ZXBi9hWEAP02Kq9O1EK/TYp24VOsP5eu885wo+t+ynT3Y80OmAux3oN13+ztUzne
 WewwEyDnbwd6egxf+5+PsAe2KUEdvp80LOErjFwUf/rlg8VmOc5TmmgdvZqrRINDmcHx2hb+kvjY
 MSg1O9jlcFeiwd6G/JABbKl/d5wvz25WxpLvJQch9a84ocD+HpMJ647lNwN4qOsSZg+fYhVZG4mh
 yjRtVCRmo/KLfKlWmgufHFIwhu0oznfSscIjbgCEW8FLB4OaDyJuGHToBIYrrlDXmPN7G7txF2nS
 g2cyQb8Y5qkVLHiOZSn5k9NADD0BBW1oT5qIEWguCTF5tOP3jj0yLjiiCMcv+tRXcSj1CD4=
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

Am Tue, 7 Oct 2025 21:40:03 +0100
schrieb Conor Dooley <conor@kernel.org>:

> On Sat, Oct 04, 2025 at 08:03:53PM +0200, Thomas Wismer wrote:
> > From: Thomas Wismer <thomas.wismer@scs.ch>
> > 
> > Add the TPS23881B I2C power sourcing equipment controller to the
> > list of supported devices.  
> 
> Missing an explanation for why a fallback compatible is not suitable
> here. Seems like it is, if the only difference is that the firmware is
> not required to be refreshed, provided that loading the non-B firmware
> on a B device would not be problematic.

Loading the non-B firmware on a B device is indeed problematic. I'll
append the following paragraph to the patch when reposting it after
the current merge window has closed.

Falling back to the TPS23881 predecessor device is not suitable as firmware
loading needs to handled differently by the driver. The TPS23881 and
TPS23881B devices require different firmware. Trying to load the TPS23881
firmware on a TPS23881B device fails and must therefore be omitted.

> > 
> > Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
> > ---
> >  Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
> > b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
> > index bb1ee3398655..0b3803f647b7 100644 ---
> > a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml +++
> > b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml @@
> > -16,6 +16,7 @@ properties: compatible: enum:
> >        - ti,tps23881
> > +      - ti,tps23881b
> >  
> >    reg:
> >      maxItems: 1
> > -- 
> > 2.43.0
> >   



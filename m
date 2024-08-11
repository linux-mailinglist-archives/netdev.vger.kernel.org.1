Return-Path: <netdev+bounces-117461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E505194E080
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 10:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C3B2817E1
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 08:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE815200DE;
	Sun, 11 Aug 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LPYUem3m"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C701C2A3
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723364870; cv=none; b=CDQsnXd9mCqwOzhOadlfc/p1T4W/ONggwx4FT0Gqs1T142H6IPKBwQV+2CLv53q0zTIyo1Q9W0r3X1b1i7SbMER5WFs5q21+B5aWYkeIes7d+7cVgBCLb4WZnDjVS+wTcRsv9tY+fA7BZnfNxcxupH0+7a5BVDCwDSMofbSjRig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723364870; c=relaxed/simple;
	bh=Qhmh4vHnMwR09FcqnztcL5p/rz07onV7DYa0VfVnsn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uARpaN+oi8SQ9/I08AcVGQtxVfcgrzS8r2qvHmhaQJLEePhMBEPVwGNTTn+BG5bj/qovTZtmpUWyJ+tAv0VLK/1PgIwvi2LOpd18IyPlW/iDOfqMcxvoz+rvu6TaLBE5HGJb9y8kGcMR+hp57JB1/rA2MvDSC00RAcJmJRgnD5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LPYUem3m; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2C67FF804;
	Sun, 11 Aug 2024 08:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723364866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvPJbCfTd0/tqt+3KPfA5Qteq/+/LBJPl0ZeHSp4bvY=;
	b=LPYUem3mT1frTQ3A1whkWc+yEG9XAnT1EcZsExxNr0jX0vLYtD73Vs0jg0Xi5HwJ7oM6ul
	+ojacXBg+sJkCk6qvPSA+HVZM9P1En27FAmDFVSZCIH6JyVUzvwzNoQ4PlwJU4h+N6iI+k
	ehsgBqkRBd7QHxA9ioDgVfV7QFQMrMsw0YMr9tEokkTAFYTdOBxQIjXkhTAaxX/TFbZfTD
	XgGiNQ85sYZudgXHKijcExuNUMQb4RHr7HU47j6XEaopuXtmiCyCtD/ipL1QNGKeVrba99
	8KXZOuvMVOHJyI7+MV65s5AkKB/X1W385U4p+PRKeZMTD/0lX6+99AtJja6HNw==
Date: Sun, 11 Aug 2024 10:27:45 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, ahmed.zaki@intel.com,
 sudheer.mogilappagari@intel.com
Subject: Re: [PATCH net 2/2] ethtool: rss: echo the context number back
Message-ID: <20240811102745.542f6d02@kmaincent-XPS-13-7390>
In-Reply-To: <20240724234249.2621109-3-kuba@kernel.org>
References: <20240724234249.2621109-1-kuba@kernel.org>
	<20240724234249.2621109-3-kuba@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 24 Jul 2024 16:42:49 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> The response to a GET request in Netlink should fully identify
> the queried object. RSS_GET accepts context id as an input,
> so it must echo that attribute back to the response.
>=20
> After (assuming context 1 has been created):
>=20
>   $ ./cli.py --spec netlink/specs/ethtool.yaml \
>              --do rss-get \
> 	     --json '{"header": {"dev-index": 2}, "context": 1}'
>   {'context': 1,
>    'header': {'dev-index': 2, 'dev-name': 'eth0'},
>   [...]

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


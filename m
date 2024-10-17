Return-Path: <netdev+bounces-136632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8E29A27F3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF7A1F21BA8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F281DE2A6;
	Thu, 17 Oct 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZAhEB+cX"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FCB1DC739
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181165; cv=none; b=ocvAROJUdQTeY+6R5+4pLMQd/FDt97P+yKnlsXHv1eCO8yuN/Fdl6EsUUPWzkOl5FezfFqh0S7DM6KoFobMR8jglCPADkShHtjYvuP3pJ06FLBrDsFRPBlDn51TLF990syjYCJiaEsY41qAJL+d9NON0QAtDJsGz/deQwU1xt1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181165; c=relaxed/simple;
	bh=+xA+EUNfBXxLP4tqaBIvwj+75e/gwGcWr8m73P4Um0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=I/ebIynJpuGEIetkBtmVvZYFwu3KyNCiY6pSJL0qssQajcMcbzU8Yx/dJANq8bJ2x8Y2EFRfTzaDZE4xVSK0XyfbVXS+BwHuAjaFaGHES62JbJoNsnJu9/R5BXLSadLxKbwRxF7V8OtiQvxrViDQW1KtCTbucyeOP7a9UeyOF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZAhEB+cX; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC00F240009;
	Thu, 17 Oct 2024 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729181152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=asZfBDocYKxb3D6ayAX2zzxF9GzKP24K1ak3n+T+jGE=;
	b=ZAhEB+cXMfzUrVkEL/LAttEJtE4OaLL4OpA/S6RQ1PUSE+MFO4YYGzJ05mH4OK28JL+tJr
	oeIyeAA9Xzwrl5kfCKzMgeQu15GdqtHAcWmwSKZuLczoqCQuZjIMTk/Q8/uJKHfvd83xBK
	YGdV1F92RihK4USOMBkqHlsFkfKXFAnjCmKhTiqCg9/g8fklrKV7TaChwQeJfnxnKw2h5C
	p7S05EL367SZHOZW678zr+x1TdPdEfC8KVoEsOKnhf55jg0HHNFS+lkP5Ksd7ClXov/5/K
	WeyzdIYBxKgtkrnOcM92y0OlfOAczBf0xtPCvF7+mSjLDY3woSvAmQYPQXRP0Q==
Date: Thu, 17 Oct 2024 18:05:51 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: ynl ethtool subscribe issue
Message-ID: <20241017180551.1259bf5c@kmaincent-XPS-13-7390>
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

Hello,

It seems there is an issue with ynl tool and ethtool specs:

# ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --subscribe mo=
nitor
 --sleep 10 &
# ethtool -K eth0 rx-gro-list on
# Traceback (most recent call last):
  File "/root/ynl/lib/ynl.py", line 723, in _decode
    attr_spec =3D attr_space.attrs_by_val[attr.type]
                ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
KeyError: 4

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/root/./ynl/cli.py", line 114, in <module>
    main()
  File "/root/./ynl/cli.py", line 109, in main
    ynl.check_ntf()
  File "/root/ynl/lib/ynl.py", line 930, in check_ntf
    self.handle_ntf(decoded)
  File "/root/ynl/lib/ynl.py", line 898, in handle_ntf
    attrs =3D self._decode(decoded.raw_attrs, op.attr_set.name)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/root/ynl/lib/ynl.py", line 732, in _decode
    subdict =3D self._decode(NlAttrs(attr.raw), attr_spec['nested-attribute=
s'],
search_attrs)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^
File "/root/ynl/lib/ynl.py", line 726, in _decode raise Exception(f"Space
'{space}' has no attribute with value '{attr.type}'") Exception: Space 'bit=
set'
has no attribute with value '4'

I used set_features netlink command but all of ethtool commands are not wor=
king.
I am not a ynl expert so someone may find the issue before I do.
That would be kind!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


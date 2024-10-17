Return-Path: <netdev+bounces-136766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737A9A3077
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 00:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D636528658D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5001D5ADA;
	Thu, 17 Oct 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOkFuXwC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3D1D0E36
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202731; cv=none; b=Tzr8RXgvgklnn8eXQ4aCczsgEg4AxMf+bqEN6ws48bdH2lIFMdFmY8e0BiK1Kci92tB4iBTrPRI5v4BxSLBGzcAbvIaZYP9XRMUZqL4PlwIzcNxcGEImETQPeYgqvzwsKnOWNgo7Hn/Rt+ZlKmx/UefQGmj/lGfWJBQMm/O+o+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202731; c=relaxed/simple;
	bh=N1X486hgsIt8oYebcWWO1J5aAV75hPxmiQ6VZPHN5bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lc5oLWP61vv6rRj3dk6W3A3x615fOBuU90mvm9lh1C4JoMI+NpYc1hMn6DPRGyWEGqsU8fjBMofxpMOy/YvsSoKr621k9Yd60y9U/XkLrxwqIB9X/TSabgvx4fjFo1PMZ2P7l6lNdDxf3D5anknOy3LxgLyrHr7CAxg1kc3iHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOkFuXwC; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5f533e1c2so737830b6e.3
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729202726; x=1729807526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zIsRjPPwVLqCITPu3AKRf9vo4xl0fFHycnQlnFeORHg=;
        b=nOkFuXwCQJq08n1ao3PGq4G3HthFuaSp6npyOS109T2V7sdZu+9t+sYkbPCRpiiHJN
         ZmkrmhI8D+0Zcpu4vVfZgbINlBEdO2fNb19AaFcBWSHJzocO5ziFGpk/3Pwc337TL8tL
         ropjDJxXAN5CbL5LenuBx8vcqWbgr9hNB/USM5by495zljhRY3bHEQhUbAEOLuuoFLG5
         +N0qEGO9eoWLBnJmYS0rMWGC+EhrqW/nfHcN9UJmx0H6GH2uwqny/duUpfL0oK7Jj8SG
         6xNKs3GBAn7SK6vHgDVAX/6qTnnJ0Edr5YTEzeq3BqT2PpRKL9VPwjBEGULxQA8l93ap
         UH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729202726; x=1729807526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIsRjPPwVLqCITPu3AKRf9vo4xl0fFHycnQlnFeORHg=;
        b=Mq2iAAiT8+3sPz39Cox0bXJIE2CesVz5i1Ri4R6esZasQclwiQY5FKamIjydDLqJN7
         om6gUPSnJkUUyRgoifAia4PSa+bF233uJDsvQuDgJOB8Wz3RNXqpIlEkn8FS15s5DeZu
         v82fvvRfHCwhMCYp0mM9SflgzW1Ho5Nin5BJteGmBOukA/+ZPacp1HRkKJKp2qSZPAi/
         qFpFIr71QPVWKej5r/4po3OxTP07oEnyRjviftOiBcztMVARJ6R0C264WnmbMibl1Kim
         jv6FUrryzRxa69CcQdKEJeRxnT7FS26QatU40I9uO7VW3aBftjWE0QrZt3Z4qLPARP/B
         tuAw==
X-Gm-Message-State: AOJu0YzsyAe/u31c/KCFJqGEnNLPikwFUWMzanyA9K2H8fZRIxgItZWz
	f9Zsj5KYCnySKL5hk6lf9HGMPDatgGelNXEXRM5lhjPca923OEJQb96KCMyn/AVVOZOYctF43rF
	r82Gbk4+oiJao/8u/3AkEkl/Tt+3irP1H
X-Google-Smtp-Source: AGHT+IGNzMSmhVEcZirEUbv2ZkntG1wRzQVQ3BXeWxzY0mT0+ZZLvDn4VQk+6s7lWYEXVv1OFhfSHF7A5gFXjy2s2gc=
X-Received: by 2002:a05:6808:3a07:b0:3e5:df4c:d473 with SMTP id
 5614622812f47-3e602df4a3emr130123b6e.47.1729202725565; Thu, 17 Oct 2024
 15:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017180551.1259bf5c@kmaincent-XPS-13-7390>
In-Reply-To: <20241017180551.1259bf5c@kmaincent-XPS-13-7390>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 17 Oct 2024 23:05:14 +0100
Message-ID: <CAD4GDZzQc1M+b_um-VH1zfq5RSMNwoWNp+8yT=D-e4_pHSpBjQ@mail.gmail.com>
Subject: Re: ynl ethtool subscribe issue
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Oct 2024 at 17:05, Kory Maincent <kory.maincent@bootlin.com> wrote:
>
> Hello,
>
> It seems there is an issue with ynl tool and ethtool specs:
>
> # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --subscribe monitor
>  --sleep 10 &
> # ethtool -K eth0 rx-gro-list on
> # Traceback (most recent call last):
>   File "/root/ynl/lib/ynl.py", line 723, in _decode
>     attr_spec = attr_space.attrs_by_val[attr.type]
>                 ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
> KeyError: 4
>
> During handling of the above exception, another exception occurred:
>
> Traceback (most recent call last):
>   File "/root/./ynl/cli.py", line 114, in <module>
>     main()
>   File "/root/./ynl/cli.py", line 109, in main
>     ynl.check_ntf()
>   File "/root/ynl/lib/ynl.py", line 930, in check_ntf
>     self.handle_ntf(decoded)
>   File "/root/ynl/lib/ynl.py", line 898, in handle_ntf
>     attrs = self._decode(decoded.raw_attrs, op.attr_set.name)
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/root/ynl/lib/ynl.py", line 732, in _decode
>     subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'],
> search_attrs)
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> File "/root/ynl/lib/ynl.py", line 726, in _decode raise Exception(f"Space
> '{space}' has no attribute with value '{attr.type}'") Exception: Space 'bitset'
> has no attribute with value '4'

The 'bitset' attribute-set is missing these attributes which are
defined in include/uapi/linux/ethtool_netlink.h

ETHTOOL_A_BITSET_VALUE, /* binary */
ETHTOOL_A_BITSET_MASK, /* binary */

This patch fixes it:

diff --git a/Documentation/netlink/specs/ethtool.yaml
b/Documentation/netlink/specs/ethtool.yaml
index 6a050d755b9c..f6c5d8214c7e 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -96,7 +96,12 @@ attribute-sets:
         name: bits
         type: nest
         nested-attributes: bitset-bits
-
+      -
+        name: value
+        type: binary
+      -
+        name: mask
+        type: binary
   -
     name: string
     attributes:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/ethtool.yaml
--subscribe monitor --sleep 10
[{'msg': {'active': {'nomask': True,
                     'size': 64,
                     'value': b'\xb2A\x00\x00\x00\x01\x00\x00'},
          'header': {'dev-index': 2, 'dev-name': 'enp42s0'},
          'hw': {'mask': b'\xff\xff\xff\xff\xff\xff\xff\xff',
                 'size': 64,
                 'value': b'\x93I\x19\x00\x00\x1b\x00\n'},
          'nochange': {'nomask': True,
                       'size': 64,
                       'value': b'\x004\x00\x00\x00\x00\x00\x00'},
          'wanted': {'nomask': True,
                     'size': 64,
                     'value': b'\x92I\x00\x00\x00\x01\x00\x00'}},
  'name': 'features-ntf'}]

> I used set_features netlink command but all of ethtool commands are not working.
> I am not a ynl expert so someone may find the issue before I do.
> That would be kind!

I haven't tried anything else from the ethtool spec, but plan to check
it out tomorrow.

I can submit a patch for this tomorrow, unless you want to?

Cheers,
Donald.


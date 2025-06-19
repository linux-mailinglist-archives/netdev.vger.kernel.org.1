Return-Path: <netdev+bounces-199442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877ACAE0566
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4412017A66C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533ED22F767;
	Thu, 19 Jun 2025 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfFNsEJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F28021A445
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335599; cv=none; b=WbPDs7S8Z8pLL6Sx+kiBq2dUSe6W3xeRM2HpFZaAveEBqobBdFVFgbvwjplDnR4QjeFvjkEvr+5UuKem8x+ulFP8q9uIQXs7AINV2/4D+TMqx+hcpyBf7L4mgkvyyXdtcHCMC9hFR6b8Vhz8LsJ01L9TC3y1Odh7TdX1QShgweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335599; c=relaxed/simple;
	bh=63j0QxbdmP5CinHYu4EOU7oYdPwkxvwk+/zDhHRUwQo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=YXqyXTWiNvh6ZrI6dfYABnwFnaJi3aCL9MBQeq+UvAkjJxZZhyIvdu3B5AqLlwnifNvczpglwT4xhjry3rn4j3LWZHTP5Muw2tc3ZgkjMqBlqwxM3SomwrbtVYaNiHq2N5yXkxjqeYk6bjYw9EhNqLThx09fwmuYGSqVEZPqlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfFNsEJ1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so6361715e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335596; x=1750940396; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=axvkajl5oWaBRfH9pg5Yg83K+9A3grQLIj056Wvd1DU=;
        b=cfFNsEJ18blJe9ECNs5fvLsdF1H07BAcFe860wLaQ37FV7DlZzTCryEUxErO2d+svA
         1YNlpSuKLqU3yPNZTIcas3/KRDrMcDf/424sdofGtIH/Okmqs+A7sz/X6EpG/ghahcX4
         tVTiXa0kGZheNVd0SJDMM6GqSiE8VAvke0Pm+U9c2DhZPVxqBd8eo7aMqm4wnrfO9JRB
         xZCtYyKssCvNTlbBio4aN28mFedojTshPCCskZzLxfmSwTZ0D2nkrjV1Pv9OWcOj9GZh
         3C4pBqYv5sR/Vdkpgazb1rqNbrs2rrug5TACwC4KtXVoWBXhZ7Pbx79KtDZxx5Qs6iDS
         DRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335596; x=1750940396;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axvkajl5oWaBRfH9pg5Yg83K+9A3grQLIj056Wvd1DU=;
        b=KHN71Wan6iucXTDBhz24ujlWlBp95PyyfiJfuYGESnHDiv/wxPhllLERuo9/UbMifb
         aMY7gZcK1zcCgnyMW3/rvmg7B86kDGOiVbmZxZt/QokT16zfdAW4fQsjI4FOwNfV4jit
         iyYkPxax3ABqj3JeP6YUoLyfPFOR9tx04DQsxWJWIqUMCqJS34tfBFYAM7dCjC7ETYY6
         b/uXneQle0XTjvkUnJfSOCEz7lvOHoGSPNx75lUmZ6Ph0w9Wsmsb13isgFuBHLF/Dk1h
         Oo0ZefteYRhle75ptGqn7Ih10cu0nV6YlBEKTlrxBgyI+ujl9U6z1MMVirZPYlwcz+wb
         2aiA==
X-Forwarded-Encrypted: i=1; AJvYcCUiddEnRVfpd61rz//7On5tj/WSE5ZXo8aqi7m5qEYGC04xqOx3VvYzMLBqzD0pLn4VA36s2/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfEkKyXGdzjhEus+vZQf6OS+flU99cyJ5vvp/9Cur0rQ1WXqE
	6RA6F3fooNep2kHp0ey6/bXO4tBvsgMDSxcH+q9NU89cfsVOSkDeq0/x2jKBgw==
X-Gm-Gg: ASbGncs+juM260YufhfP8O6K+PeZAE7Qu8ovTSvMPUWVJf4tAlzcOqwyQi6yjgYZnkK
	6h1ke70xtuIfnrssfnKw6m30Ycgje5W/jwIc3q7Ogoi/+ursowNHvtHQOktntrTg3scznOE5X0t
	1CY+WBJeEaPxbMPBmBpfgWXbn5GRcrrm5mzWkIOemAbpNP973dWceLcal5s8oEIDLdOxXLqI0WL
	9iCUxktg/BXPVSIF5iUINhZrV7R4GsRdxdBmdv4lLrxOwYaUA7MfdUbaOQrCtgxIXXdLGbIraQ+
	oaxlIzDGPtXLLIS3I0FtLd3J8uB2JvatUlT4gBMt9mGgxGDii3oXNUmIjFBB/eYJGkwVSkkhwEy
	C5nno4pE=
X-Google-Smtp-Source: AGHT+IGclfkXhEKwf1+0V1AccdcM1Hr7020xntVo1zpQedUGP1LGnTdL5oy+8hOkHNMyZqogIT72og==
X-Received: by 2002:a05:600c:8b26:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-4533ca6635amr225883135e9.10.1750335595308;
        Thu, 19 Jun 2025 05:19:55 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:ad83:585e:86eb:3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535f7febcfsm21723105e9.18.2025.06.19.05.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:19:54 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH net] tools: ynl: fix mixing ops and notifications on one
 socket
In-Reply-To: <20250618171746.1201403-1-kuba@kernel.org>
Date: Thu, 19 Jun 2025 09:25:55 +0100
Message-ID: <m234bwgmss.fsf@gmail.com>
References: <20250618171746.1201403-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The multi message support loosened the connection between the request
> and response handling, as we can now submit multiple requests before
> we start processing responses. Passing the attr set to NlMsgs decoding
> no longer makes sense (if it ever did), attr set may differ message
> by messsage. Isolate the part of decoding responsible for attr-set
> specific interpretation and call it once we identified the correct op.
>
> Without this fix performing SET operation on an ethtool socket, while
> being subscribed to notifications causes:
>
>  # File "tools/net/ynl/pyynl/lib/ynl.py", line 1096, in _op
>  # Exception|     return self._ops(ops)[0]
>  # Exception|            ~~~~~~~~~^^^^^
>  # File "tools/net/ynl/pyynl/lib/ynl.py", line 1040, in _ops
>  # Exception|     nms = NlMsgs(reply, attr_space=op.attr_set)
>  # Exception|                                    ^^^^^^^^^^^
>
> The value of op we use on line 1040 is stale, it comes form the previous
> loop. If a notification comes before a response we will update op to None
> and the next iteration thru the loop will break with the trace above.
>
> Fixes: 6fda63c45fe8 ("tools/net/ynl: fix cli.py --subscribe feature")
> Fixes: ba8be00f68f5 ("tools/net/ynl: Add multi message support to ynl")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Good catch, fix LGTM. It looks like a followup refactor could combine
annotate_extack and _decode_extack and get rid of the attr_space
parameter to NlMsg(). WDYT?

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> ---
> CC: donald.hunter@gmail.com
> CC: arkadiusz.kubalewski@intel.com
> ---
>  tools/net/ynl/pyynl/lib/ynl.py | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
> index ae4d1ef7b83a..7529bce174ff 100644
> --- a/tools/net/ynl/pyynl/lib/ynl.py
> +++ b/tools/net/ynl/pyynl/lib/ynl.py
> @@ -231,14 +231,7 @@ from .nlspec import SpecFamily
>                      self.extack['unknown'].append(extack)
>  
>              if attr_space:
> -                # We don't have the ability to parse nests yet, so only do global
> -                if 'miss-type' in self.extack and 'miss-nest' not in self.extack:
> -                    miss_type = self.extack['miss-type']
> -                    if miss_type in attr_space.attrs_by_val:
> -                        spec = attr_space.attrs_by_val[miss_type]
> -                        self.extack['miss-type'] = spec['name']
> -                        if 'doc' in spec:
> -                            self.extack['miss-type-doc'] = spec['doc']
> +                self.annotate_extack(attr_space)
>  
>      def _decode_policy(self, raw):
>          policy = {}
> @@ -264,6 +257,18 @@ from .nlspec import SpecFamily
>                  policy['mask'] = attr.as_scalar('u64')
>          return policy
>  
> +    def annotate_extack(self, attr_space):
> +        """ Make extack more human friendly with attribute information """
> +
> +        # We don't have the ability to parse nests yet, so only do global
> +        if 'miss-type' in self.extack and 'miss-nest' not in self.extack:
> +            miss_type = self.extack['miss-type']
> +            if miss_type in attr_space.attrs_by_val:
> +                spec = attr_space.attrs_by_val[miss_type]
> +                self.extack['miss-type'] = spec['name']
> +                if 'doc' in spec:
> +                    self.extack['miss-type-doc'] = spec['doc']
> +
>      def cmd(self):
>          return self.nl_type
>  
> @@ -277,12 +282,12 @@ from .nlspec import SpecFamily
>  
>  
>  class NlMsgs:
> -    def __init__(self, data, attr_space=None):
> +    def __init__(self, data):
>          self.msgs = []
>  
>          offset = 0
>          while offset < len(data):
> -            msg = NlMsg(data, offset, attr_space=attr_space)
> +            msg = NlMsg(data, offset)
>              offset += msg.nl_len
>              self.msgs.append(msg)
>  
> @@ -1036,12 +1041,13 @@ genl_family_name_to_id = None
>          op_rsp = []
>          while not done:
>              reply = self.sock.recv(self._recv_size)
> -            nms = NlMsgs(reply, attr_space=op.attr_set)
> +            nms = NlMsgs(reply)
>              self._recv_dbg_print(reply, nms)
>              for nl_msg in nms:
>                  if nl_msg.nl_seq in reqs_by_seq:
>                      (op, vals, req_msg, req_flags) = reqs_by_seq[nl_msg.nl_seq]
>                      if nl_msg.extack:
> +                        nl_msg.annotate_extack(op.attr_set)
>                          self._decode_extack(req_msg, op, nl_msg.extack, vals)
>                  else:
>                      op = None


Return-Path: <netdev+bounces-77071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C5487008E
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D577C1C21024
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ADD3BBCD;
	Mon,  4 Mar 2024 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQJDGyU0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06993BB3E
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552491; cv=none; b=MBPfVSYd0ZpFpR33Fi0p6X/Nd3BgSoMAQmbz9FaIUIKwcn4eFNcsUFEzbiwusY5zmtU7IDjMpcY72jxJS1g/6Qssz/PUnVBD/S03alkA2M5Kw4jBjDjhzYgBa0/np8Q9oI3arHIkGjhQ9P/O9NQoawYDoek7yQHMONm2sxDzrEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552491; c=relaxed/simple;
	bh=DpZ4yp9DUTfeWWXiUE/vgqUCV7aslPDxosuH/InZW3I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=g3r6v4jQpi8zbbN0j/vT/daUnCLF36Ikfrm+CMXUYI8SU+Gn2rF25r3p/bbJFyNzB62o4NdH1yHqVlJSSVO9+NwpbD22UjE9UE+xZ2vxWOn7QxtQ1Lhgiu5mgYNa+N7cMqLxVdgBOGLboDnrCJiQ4LMvh2a8TpAawHjUo7RZIKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQJDGyU0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33dcd8dec88so2758466f8f.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 03:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709552488; x=1710157288; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wN4F9+ASn5IeDDvPPQ5ZdTIE0MiAOrK1uDvCR+BYPMo=;
        b=iQJDGyU04f6wFV7bmjg5d2iCHjRpIxR1Vd7CXiib6j4dWk+V5RCl0bE7M9+7mqwM+c
         KlQ4QBd0E+WA7NSFyBhdLrOX8J3Zt7iwTh7kgn+nOeO1hFb1edQjcY78O2NiVSk1yKQe
         C14w7mCOl8eduSpq0ox2VVs/I42hKKlqUl5lQfsdOqLcsvoAVRAk6RFGBESLb02YBc5t
         vPEkA2S6ifjdpsskDCs2I6LGaMWr42rTum+SBxrESzZYFvdG0Iv0hjdLglSHWcfpcpiP
         eyKq3UIGuVEyiaPAau3QyOkF6/lRkocwbGTxQDO58tSEVK4BnfVy3kW/jlRy/5qGld9C
         VT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709552488; x=1710157288;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN4F9+ASn5IeDDvPPQ5ZdTIE0MiAOrK1uDvCR+BYPMo=;
        b=t0YMBvBDZ+7SXfeGLjZx/BZZhpB61fZ6GoqqT08UWxrXJkRPE/zZPaNteABJ6NnEFZ
         0qB19R4c+gfKglZZSE+LcO8FvPx8RhuTZLIvoolXENx+mfDfQd7gSvz+y2hU8X1vhV7V
         qISHmZYTZwLWcAxLxK80KhXoOvyFq4400iqn8HwIAPx96rVyEDl8nWLCapBfkw8slmKN
         pMtndVdG9uwmEtvbLzlhAA4ce7ZkXiHkjGExe2dT4bmogVd+Gje7HSeB/K89GQYfjW8D
         lzLllJDL8PjP25AIDtiq+6TS4B9H1OGkZ9MgHGcEBb9nU/c+3vIlbjaPkQgl6jVkkV3T
         dtJA==
X-Forwarded-Encrypted: i=1; AJvYcCUY4jlE5I5GRnRA7O1KfDEAAHmLzLZsybbCMo2xswreTdy7H01lpj/djJXDkkfJSdMOGWgOGEhINgy4QCyI1a+3fGMOl4bt
X-Gm-Message-State: AOJu0Yz/5Dix2o7CvsQiUzQGBSsXfH/anle/Un6KvfgXGfo7B5YmIslM
	Vy6kGu+YLQCNKcTvih2WqizZG1c6WUNGIXFznsSqr2M/whVpaKic
X-Google-Smtp-Source: AGHT+IEHe984ZjlmvWYIN4CnlEGhBpk6nuezwvX+Kvl6zTGVNdyHKnHCfNsOqHr1Ks3mCrpWfDBZlQ==
X-Received: by 2002:a5d:67d2:0:b0:33d:1d32:1717 with SMTP id n18-20020a5d67d2000000b0033d1d321717mr5315734wrw.70.1709552488287;
        Mon, 04 Mar 2024 03:41:28 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:29eb:67db:e43b:26b1])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033e052be14fsm11941359wrw.98.2024.03.04.03.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:41:27 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 2/4] tools: ynl: allow setting recv() size
In-Reply-To: <20240301230542.116823-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 1 Mar 2024 15:05:40 -0800")
Date: Mon, 04 Mar 2024 11:38:29 +0000
Message-ID: <m2le6yjkga.fsf@gmail.com>
References: <20240301230542.116823-1-kuba@kernel.org>
	<20240301230542.116823-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Make the size of the buffer we use for recv() configurable.
> The details of the buffer sizing in netlink are somewhat
> arcane, we could spend a lot of time polishing this API.
> Let's just leave some hopefully helpful comments for now.
> This is a for-developers-only feature, anyway.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/lib/ynl.py | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 92ade9105f31..bc5a526dbb99 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -84,6 +84,10 @@ from .nlspec import SpecFamily
>      return f"Netlink error: {os.strerror(-self.nl_msg.error)}\n{self.nl_msg}"
>  
>  
> +class ConfigError(Exception):
> +    pass
> +
> +
>  class NlAttr:
>      ScalarFormat = namedtuple('ScalarFormat', ['native', 'big', 'little'])
>      type_formats = {
> @@ -400,7 +404,8 @@ genl_family_name_to_id = None
>  
>  
>  class YnlFamily(SpecFamily):
> -    def __init__(self, def_path, schema=None, process_unknown=False):
> +    def __init__(self, def_path, schema=None, process_unknown=False,
> +                 recv_size=131072):
>          super().__init__(def_path, schema)
>  
>          self.include_raw = False
> @@ -423,6 +428,16 @@ genl_family_name_to_id = None
>          self.async_msg_ids = set()
>          self.async_msg_queue = []
>  
> +        # Note that netlink will use conservative (min) message size for
> +        # the first dump recv() on the socket, our setting will only matter
> +        # from the second recv() on.
> +        self._recv_size = recv_size
> +        # Netlink will always allocate at least PAGE_SIZE - sizeof(skb_shinfo)
> +        # for a message, so smaller receive sizes will lead to truncation.
> +        # Note that the min size for other families may be larger than 4k!
> +        if self._recv_size < 4000:
> +            raise ConfigError()

Nit: You've added this between the declaration of async_msg_ids and
where it gets populated. Otherwise LGTM.

> +
>          for msg in self.msgs.values():
>              if msg.is_async:
>                  self.async_msg_ids.add(msg.rsp_value)
> @@ -799,7 +814,7 @@ genl_family_name_to_id = None
>      def check_ntf(self):
>          while True:
>              try:
> -                reply = self.sock.recv(128 * 1024, socket.MSG_DONTWAIT)
> +                reply = self.sock.recv(self._recv_size, socket.MSG_DONTWAIT)
>              except BlockingIOError:
>                  return
>  
> @@ -854,7 +869,7 @@ genl_family_name_to_id = None
>          done = False
>          rsp = []
>          while not done:
> -            reply = self.sock.recv(128 * 1024)
> +            reply = self.sock.recv(self._recv_size)
>              nms = NlMsgs(reply, attr_space=op.attr_set)
>              for nl_msg in nms:
>                  if nl_msg.extack:


Return-Path: <netdev+bounces-65135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966983954D
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF5F1C243AC
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80912836E;
	Tue, 23 Jan 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aiz+QNSt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960D81206
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028345; cv=none; b=T+51Rrgeu5nz7FR+Ib3sHpaHY7IW//bjRlINb83m2RZ35SFYVn80/s2wqusnPjCmlU1qto52YR+oyz7KBPPlhlEB5ezK6gG/QORYvq8dMnyKTVL+TDTQib3Os5GR4hAuG/Y3R1ZfqjnPRAml9OJxvF7jGf4X3e5XkRFEdEID9A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028345; c=relaxed/simple;
	bh=XloI80kDXJMzwa/G2lqshz350ZZem2tLB8k27Wk8tLk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=WVvJuPy+bAnBmKtjBXudkpqFy+o1BLaDZQsJ3xKue4keYak+fUrequkZYjitrJkBgXCyxR8dZJ7tyb3WNsPCVmlYiljH4ihThqVCUHaTYkt6kAFhqhN52LfCAou2tI+BpV83flZJlBqFj9aQ/j3ZXAZiNqDoo94Cr+9qUsVkgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aiz+QNSt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-337cf4eabc9so3705079f8f.3
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706028341; x=1706633141; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hLbFVZ5H0nJr2QFgThHSPlcXr0HWDPY5fb+gH2cXnY=;
        b=Aiz+QNSt4xoUu6kvHDihf4ALOm89qfgogwGpF007ddVmxWodAXbKlpQoiEEPVFCMXa
         wtiGE9X0SRBQz/EU6xkzPbaAq7RU7b6RTfqPMvQmd3ytZuYBl64fjgHWQGzJ7KwVDNqC
         /e/GJkR3qT1iemyxsljZ9T2UelWI/bZ2MuVJ3OCyr6YQSbDT1RoUNqQKGknqSryJjSUj
         og4L4jevrQOKiO1Z4lr3azjuLG1+itXvRvYAsMI4fi0UGBhNFkmEpyxIpCxgANjx7b2x
         K5XBc/dRj8bvISO6Pj3wZ9iSXBEXSgZBKnjvRh9i9nncWxE0pCXsYHpkMdvNLZrIieMY
         X9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028341; x=1706633141;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hLbFVZ5H0nJr2QFgThHSPlcXr0HWDPY5fb+gH2cXnY=;
        b=Gtgp5CjT+Kibks8wfhm1kRsXg2RbI6gpaJcFnkqqICSQYmBif0FX3wboLDN/+fD+I2
         p1uPM7JcAhrdYd7zBeSR9DgUz+lXMsDQSBlDe3pMcFN38Uv9pWoJnBD2dgvKtf32zVWi
         q0k9M8Hnh62VulXc5FHc1uZ2MTutbos93/BofBYeDUiN/Xa5DW/71BGI6DbOIzzSBMGG
         moR/GB07AUrVNqUqn6zpsMswAFmWbnxKbrsEHmwQ4bRw4TNNBL8maUsWdBR5DQVFS56t
         a4G0ARLYzW5Q/O7Cm+jUb5Z0529WjvdToXMl4nWN1trm/MhW+Zip2AmaHuzlIetbBmvT
         wASg==
X-Gm-Message-State: AOJu0YzH6Cbqe5f3UgX6PBlbeG4rbLJA+H4Tm8Eq78gNCR1AaG4ggGJj
	dE5xUCxNt052E/wcPpIx3+b7YCGkuXicR79JraBtWovEiRdQV/EIF7HTljwcXOlbabar
X-Google-Smtp-Source: AGHT+IEINmZeMmOzNxoqYAMvG6jWYSl9WCUH4Hwmz6elrKlwnU7LYwFwctFWcRtumZyEhKMSLsnm0w==
X-Received: by 2002:adf:dd8d:0:b0:336:6ed3:2ead with SMTP id x13-20020adfdd8d000000b003366ed32eadmr3534313wrl.17.1706028341164;
        Tue, 23 Jan 2024 08:45:41 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d4a42000000b003392b1ebf5csm8708538wrs.59.2024.01.23.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:45:40 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  sdf@google.com,  chuck.lever@oracle.com,
  lorenzo@kernel.org,  jacob.e.keller@intel.com,  jiri@resnulli.us,
  netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] tools: ynl: add encoding support for
 'sub-message' to ynl
In-Reply-To: <0eedc19860e9b84f105c57d17219b3d0af3100d2.1705950652.git.alessandromarcolini99@gmail.com>
	(Alessandro Marcolini's message of "Mon, 22 Jan 2024 20:19:41 +0100")
Date: Tue, 23 Jan 2024 16:44:54 +0000
Message-ID: <m2v87kxam1.fsf@gmail.com>
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
	<0eedc19860e9b84f105c57d17219b3d0af3100d2.1705950652.git.alessandromarcolini99@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:

> Add encoding support for 'sub-message' attribute and for resolving
> sub-message selectors at different nesting level from the key
> attribute.

I think the relevant patches in my series are:

https://lore.kernel.org/netdev/20240123160538.172-3-donald.hunter@gmail.com/T/#u
https://lore.kernel.org/netdev/20240123160538.172-5-donald.hunter@gmail.com/T/#u

>
> Also, add encoding support for multi-attr attributes.

This would be better as a separate patch since it is unrelated to the
other changes.

> Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
> ---
>  tools/net/ynl/lib/ynl.py | 54 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 1e10512b2117..f8c56944f7e7 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -449,7 +449,7 @@ class YnlFamily(SpecFamily):
>          self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
>                               mcast_id)
>  
> -    def _add_attr(self, space, name, value):
> +    def _add_attr(self, space, name, value, vals):
>          try:
>              attr = self.attr_sets[space][name]
>          except KeyError:
> @@ -458,8 +458,13 @@ class YnlFamily(SpecFamily):
>          if attr["type"] == 'nest':
>              nl_type |= Netlink.NLA_F_NESTED
>              attr_payload = b''
> -            for subname, subvalue in value.items():
> -                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue)
> +            # Check if it's a list of values (i.e. it contains multi-attr elements)
> +            for subname, subvalue in (
> +                ((k, v) for item in value for k, v in item.items())
> +                if isinstance(value, list)
> +                else value.items()
> +            ):
> +                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue, vals)

Should really check whether multi-attr is true in the spec before
processing the json input as a list of values.

>          elif attr["type"] == 'flag':
>              attr_payload = b''
>          elif attr["type"] == 'string':
> @@ -481,6 +486,12 @@ class YnlFamily(SpecFamily):
>              attr_payload = format.pack(int(value))
>          elif attr['type'] in "bitfield32":
>              attr_payload = struct.pack("II", int(value["value"]), int(value["selector"]))
> +        elif attr['type'] == "sub-message":
> +            spec = self._resolve_selector(attr, vals)
> +            attr_spec = spec["attribute-set"]
> +            attr_payload = b''
> +            for subname, subvalue in value.items():
> +                attr_payload += self._add_attr(attr_spec, subname, subvalue, vals)
>          else:
>              raise Exception(f'Unknown type at {space} {name} {value} {attr["type"]}')
>  
> @@ -555,9 +566,40 @@ class YnlFamily(SpecFamily):
>          sub_msg_spec = self.sub_msgs[sub_msg]
>  
>          selector = attr_spec.selector
> -        if selector not in vals:
> +
> +        def _find_attr_path(attr, vals, path=None):
> +            if path is None:
> +                path = []
> +            if isinstance(vals, dict):
> +                if attr in vals:
> +                    return path
> +                for k, v in vals.items():
> +                    result = _find_attr_path(attr, v, path + [k])
> +                    if result is not None:
> +                        return result
> +            elif isinstance(vals, list):
> +                for idx, v in enumerate(vals):
> +                    result = _find_attr_path(attr, v, path + [idx])
> +                    if result is not None:
> +                        return result
> +            return None
> +
> +        def _find_selector_val(sel, vals, path):
> +            while path != []:
> +                v = vals.copy()
> +                for step in path:
> +                    v = v[step]
> +                if sel in v:
> +                    return v[sel]
> +                path.pop()
> +            return vals[sel] if sel in vals else None
> +
> +        attr_path = _find_attr_path(attr_spec.name, vals)
> +        value = _find_selector_val(selector, vals, attr_path)
> +
> +        if value is None:
>              raise Exception(f"There is no value for {selector} to resolve '{attr_spec.name}'")
> -        value = vals[selector]
> +
>          if value not in sub_msg_spec.formats:
>              raise Exception(f"No message format for '{value}' in sub-message spec '{sub_msg}'")
>  
> @@ -772,7 +814,7 @@ class YnlFamily(SpecFamily):
>                      format = NlAttr.get_format(m.type, m.byte_order)
>                      msg += format.pack(value)
>          for name, value in vals.items():
> -            msg += self._add_attr(op.attr_set.name, name, value)
> +            msg += self._add_attr(op.attr_set.name, name, value, vals)
>          msg = _genl_msg_finalize(msg)
>  
>          self.sock.send(msg, 0)


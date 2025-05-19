Return-Path: <netdev+bounces-191509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB40AABBAEC
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24536170C64
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D13F274FDC;
	Mon, 19 May 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyexOHD8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577E274FC4
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649977; cv=none; b=O5RRnVnCMFlYqq6fS7vTF9WDaz88gm/IL7JDUzMHPyPtRZAw3SLg3a/V+MtwmBjSwxRa+MoVjPl58tiWnELvrniW8+HGDWDJmp5VPr7VTpVQHAzhqUft2HAi83LgGnRj/ORez4pHdwjXBo6nfpwXQ9ywiJ/B30aHJowaaZ4QyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649977; c=relaxed/simple;
	bh=ucD6HrjeD0U/wtPrGhjAWIA+EpRFFeV2D4GbRJQcVjQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=TnL/rs2FjiXPW5fFYAxmgtR8lApJh9PuDLOkKthP2yi8RlUDrvibL2j+wl2kYIi80U9l+EidDUlMJ7lMUGQ4h/gyURnLBY2xcp7UhYQEjKS+SIvsX8lSaKH5nEVuRnPYOtU5psDbxIgNk45oShs8qDn02bR3LVbRdFZ34u/5j0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyexOHD8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so27060605e9.0
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747649973; x=1748254773; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLVuLTSjoPUtaXUYQ4WH9mpKEqIvEtN4bX/DXfDSm28=;
        b=QyexOHD8ZNyBsnVEFOdSJbaIq1oFKr0rAUGHVU6h9rMCfIA9VdMs/07VMOFN3OYhwb
         YtdcziLvCEd3TII8xUytXe7CPr9LZm5HXjJkqyNBpstFTaqBgTsP7LeVY7nmFbwrnFsh
         7Es9HhHTUyV7tUdtEqaezxPXqzdgI6bjjH89oraIu0OkXq7YPF4wKJtMoNBQ4T1T13K3
         vdNB7kKCcpzvfgRka3RztMsneIROy1wZDsK4UqGTo+7PpqRJRtQ626STnWITsUp+hgz6
         g80wBSsWY/pTpmNP7HqrQtYDr8nSIlHPC3EY1jNRSvwkVN2ikVR3hKqhQN5eICnWC+L8
         f+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649973; x=1748254773;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLVuLTSjoPUtaXUYQ4WH9mpKEqIvEtN4bX/DXfDSm28=;
        b=V0TwriutyQxptEUs1WpvBhHgM77DzcEGkafpLKqe/O6/9z8d6jNFbJL+6C+CONGY61
         4/uAC9EetdZPCotUOisZAfGxBHRhPZZsczSNLhv9DhOnZybyIB2zOQjKIAn8f2wJlzwb
         UAoxzA8biKm7AB7TE1LWa7FxmODUuph2gzBm3fxi0xiYD6wTHAMka28oQcPI59HfsWLo
         +QzHdyhE0Mh5DfkZ0BWVNowduCibzsnp8kPyyL/oK/2vZzUFk/uEX3HQ+gLAj9k31OP0
         qryT2L00cKO/q9XiAHDqT2f7tkN9iNNVP4iMU0Vi8vkDqKdlyP+LsKfSKrPMF1c3ymOh
         hhcw==
X-Forwarded-Encrypted: i=1; AJvYcCVUyFyO3tCzxBm/S7950jWR+zIK+bSd2QOXBCr7UmHY0WV6fL5rix+erfEW0nS7nBnMCg/t+/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExdQIOGQYmKCVxxWZnBnyeWjRHGRWk//cdA84/V/6yxTGVP2I
	dX0xb50uQRLubGzVLV9GtWShIvN8F6mt/dDONd6/HmVrc/QXTSrn3Pe+
X-Gm-Gg: ASbGnct1tugqaimyo5euHNmCOCmQSmMQZDAH89Kl5m++MouNJFSPGdHV91J5IObxziX
	UXEPJ6KWa4CRoAroXXhMMENzVh5RkDwAaeWqN/dfmSnMmPvjaYUsd9M/QDV5kfUQampvNhjVO4q
	vzs/On3HizrSt1XXju58Kqrz+54Mb6Z40BEDk7bJPGgTq+x9OPuLiylrTWoDc+dsptS+o+AO4Zc
	tNKRMJPbUQJWRMZ3nLwoW6piBK1qqR1PCJmBtwpvWIq5J3R+jGT4mwWV+h41ERZZ8M4hdj4kHP7
	fCPse4DEOkQo8NkkhNiV3e8Ej4tUBx1xCgVUzIFUbEXd3KFn0Gxtr2WnPRC8jkO+
X-Google-Smtp-Source: AGHT+IFrwOWbput1u0XAI7PllatS5Zc4CujioQcih9XQz5IvoszFXuMwa5Rgk5JL3lcDbG1exN+JQw==
X-Received: by 2002:a05:600c:c1c8:10b0:441:d228:3a07 with SMTP id 5b1f17b1804b1-442f8524304mr97680485e9.13.1747649973278;
        Mon, 19 May 2025 03:19:33 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d5e9:e348:9b63:abf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ff81ade8sm119315445e9.21.2025.05.19.03.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:19:32 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jstancek@redhat.com
Subject: Re: [PATCH net-next 08/11] tools: ynl-gen: support weird
 sub-message formats
In-Reply-To: <20250517001318.285800-9-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 16 May 2025 17:13:15 -0700")
Date: Mon, 19 May 2025 10:25:37 +0100
Message-ID: <m2frh1j6jy.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-9-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> TC uses all possible sub-message formats:
>  - nested attrs
>  - fixed headers + nested attrs
>  - fixed headers
>  - empty
>
> Nested attrs are already supported for rt-link. Add support
> for remaining 3. The empty and fixed headers ones are fairly
> trivial, we can fake a Binary or Flags type instead of a Nest.
>
> For fixed headers + nest we need to teach nest parsing and
> nest put to handle fixed headers.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/lib/ynl-priv.h     |  8 +++--
>  tools/net/ynl/pyynl/ynl_gen_c.py | 51 ++++++++++++++++++++++++--------
>  2 files changed, 45 insertions(+), 14 deletions(-)
>
> diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
> index 416866f85820..824777d7e05e 100644
> --- a/tools/net/ynl/lib/ynl-priv.h
> +++ b/tools/net/ynl/lib/ynl-priv.h
> @@ -213,11 +213,15 @@ static inline void *ynl_attr_data_end(const struct nlattr *attr)
>  				     NLMSG_HDRLEN + fixed_hdr_sz); attr; \
>  	     (attr) = ynl_attr_next(ynl_nlmsg_end_addr(nlh), attr))
>  
> -#define ynl_attr_for_each_nested(attr, outer)				\
> +#define ynl_attr_for_each_nested_off(attr, outer, offset)		\
>  	for ((attr) = ynl_attr_first(outer, outer->nla_len,		\
> -				     sizeof(struct nlattr)); attr;	\
> +				     sizeof(struct nlattr) + offset);	\
> +	     attr;							\
>  	     (attr) = ynl_attr_next(ynl_attr_data_end(outer), attr))
>  
> +#define ynl_attr_for_each_nested(attr, outer)				\
> +	ynl_attr_for_each_nested_off(attr, outer, 0)
> +
>  #define ynl_attr_for_each_payload(start, len, attr)			\
>  	for ((attr) = ynl_attr_first(start, len, 0); attr;		\
>  	     (attr) = ynl_attr_next(start + len, attr))
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index f2a4404d0d21..5abf7dd86f42 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -1372,12 +1372,25 @@ from lib import SpecSubMessage, SpecSubMessageFormat
>  
>          attrs = []
>          for name, fmt in submsg.formats.items():
> -            attrs.append({
> +            attr = {
>                  "name": name,
> -                "type": "nest",
>                  "parent-sub-message": spec,
> -                "nested-attributes": fmt['attribute-set']
> -            })
> +            }
> +            if 'attribute-set' in fmt:
> +                attr |= {
> +                    "type": "nest",
> +                    "nested-attributes": fmt['attribute-set'],
> +                }
> +                if 'fixed-header' in fmt:
> +                    attr |= { "fixed-header": fmt["fixed-header"] }
> +            elif 'fixed-header' in fmt:
> +                attr |= {
> +                    "type": "binary",
> +                    "struct": fmt["fixed-header"],
> +                }
> +            else:
> +                attr["type"] = "flag"
> +            attrs.append(attr)
>  
>          self.attr_sets[nested] = AttrSet(self, {
>              "name": nested,
> @@ -1921,8 +1934,11 @@ _C_KW = {
>  
>      i = 0
>      for name, arg in struct.member_list():
> -        cw.p('[%d] = { .type = YNL_PT_SUBMSG, .name = "%s", .nest = &%s_nest, },' %
> -             (i, name, arg.nested_render_name))
> +        nest = ""
> +        if arg.type == 'nest':
> +            nest = f" .nest = &{arg.nested_render_name}_nest,"
> +        cw.p('[%d] = { .type = YNL_PT_SUBMSG, .name = "%s",%s },' %
> +             (i, name, nest))
>          i += 1
>  
>      cw.block_end(line=';')
> @@ -2032,6 +2048,11 @@ _C_KW = {
>      if struct.submsg is None:
>          local_vars.append('struct nlattr *nest;')
>          init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")
> +    if struct.fixed_header:
> +        local_vars.append('void *hdr;')
> +        struct_sz = f'sizeof({struct.fixed_header})'
> +        init_lines.append(f"hdr = ynl_nlmsg_put_extra_header(nlh, {struct_sz});")
> +        init_lines.append(f"memcpy(hdr, &obj->_hdr, {struct_sz});")
>  
>      has_anest = False
>      has_count = False
> @@ -2063,11 +2084,14 @@ _C_KW = {
>  
>  
>  def _multi_parse(ri, struct, init_lines, local_vars):
> +    if struct.fixed_header:
> +        local_vars += ['void *hdr;']
>      if struct.nested:
> -        iter_line = "ynl_attr_for_each_nested(attr, nested)"
> -    else:
>          if struct.fixed_header:
> -            local_vars += ['void *hdr;']
> +            iter_line = f"ynl_attr_for_each_nested_off(attr, nested, sizeof({struct.fixed_header}))"
> +        else:
> +            iter_line = "ynl_attr_for_each_nested(attr, nested)"
> +    else:
>          iter_line = "ynl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)"
>          if ri.op.fixed_header != ri.family.fixed_header:
>              if ri.family.is_classic():
> @@ -2114,7 +2138,9 @@ _C_KW = {
>          ri.cw.p(f'dst->{arg} = {arg};')
>  
>      if struct.fixed_header:
> -        if ri.family.is_classic():
> +        if struct.nested:
> +            ri.cw.p('hdr = ynl_attr_data(nested);')
> +        elif ri.family.is_classic():
>              ri.cw.p('hdr = ynl_nlmsg_data(nlh);')
>          else:
>              ri.cw.p('hdr = ynl_nlmsg_data_offset(nlh, sizeof(struct genlmsghdr));')
> @@ -2234,8 +2260,9 @@ _C_KW = {
>  
>          ri.cw.block_start(line=f'{kw} (!strcmp(sel, "{name}"))')
>          get_lines, init_lines, _ = arg._attr_get(ri, var)
> -        for line in init_lines:
> -            ri.cw.p(line)
> +        if init_lines:
> +            for line in init_lines:

I have a tiny preference for this construction, to eliminate the if
statement. WDYT?

           for line in init_lines or []:

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> +                ri.cw.p(line)
>          for line in get_lines:
>              ri.cw.p(line)
>          if arg.presence_type() == 'present':


Return-Path: <netdev+bounces-188951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BD3AAF8C3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573831C0200C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A821FF1CE;
	Thu,  8 May 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCz1JGlU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58F35957
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746704015; cv=none; b=U6v7qqmp+WVF3ugTm+73OT/aLXmwnPic/oIW6KL6lVvALyBL7W492wGiMI/2Ulwppzqh4eq/giJ1wiQBVNCgOo37muTOboOSvjJVMXNHZpW+n35EblpxcC5PrP7cMSDZDaRgYyz9+BoD7jYeXkw9kZd7OnuCzb5vVVm9CFA1hCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746704015; c=relaxed/simple;
	bh=fGLa0x41+Jimm2qaNL2Z12P9Gc3o6LOa4iwbXBLk3+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QefZqs0L+yccICo5fCQI1OuhZxSc/LpoXFeTVPHWCCIPbf9JDy5bifwo+mEmrAjxmnvDTHztAsscy0GvdfQTw4PZ3NP5Z6Uh6ht6y0rkqxDEanb7OpsDa90Cgzz7/7EutcV3hhf5gkTSwlPXmFkX4SC9Hd3qR7PTOL09fslhTKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCz1JGlU; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so1255790fac.0
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 04:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746704012; x=1747308812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HflI9i4qA6/7Zb1fq2aWtrrxctmLIXqrLa8hWmLlSjE=;
        b=SCz1JGlUEJudhk4qpMbjA7f+PDkAtbQ2xyo3o4t9xfaNK2E/9R66Rg+xp10QyNojJ6
         VKPtiUgwNpBh7fps4jkj2mHYbRivLb4N4TWJHIlA0jrZ96ensRrHJsTk8TR2E+AbJ7yC
         3K52j+QNRaeYbs1oQErGaQLB6WJebVwMTQuLYYwcE+ai7iaODtBnlM5C3Ie2DgC15bl9
         fs1+inbGMIFX4vNff/mlrdQnwkBBVVzg5M1Av8u19OjQTU07+jY1HMKuxfvYTYybr588
         bPbco/o8Chn9wRklDaBjypBMVczemX87wBZPKy7+v9+G8T521A/BfcgGvhmY5Ph66XM1
         ZdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746704012; x=1747308812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HflI9i4qA6/7Zb1fq2aWtrrxctmLIXqrLa8hWmLlSjE=;
        b=HFyAB3bUfuaTkLOzNLK/brH6BAhSnT3PHHZ1GRh3ms/TT9WGod8D0CruzIn3Ig5Scq
         3BbvDUARse57Hhmf7ROascl7xTwoMw120cKy/BCpVBeaoWoBSUl0uenSwlMcNT3lOwcD
         P9RxuLbNb+23dU727Hkybk2JeJMkIidmhL2EysxD8P5+aQoDqKzFliWJEOHwTLQ0EMgY
         eluAsoPRi75gO/w6iq/9B+l5GQw+pxNGZXX0NjpI2Ft3lgWlQwzHwHrIic3auP22bDmk
         1Hfziyw2cHTm65Mrl9GKTasJgS0sXZPBpZ9s+Bf3pgkkE7jWgmgwtfRbI3Kkd9WdAsi8
         ZtGA==
X-Forwarded-Encrypted: i=1; AJvYcCUyAd/f6j2fTnJEuzGeWOlFHESLHALYWJUyInwVWk9cC8iXdMuCZPwUxST8dwKnK6UdtFvFlME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuWzAqNnSVQ/RDNfDBhDQwJbbAWm6bK6HeNJEkYxcaBh5i84g9
	0HZxB/QgvbxMuWeBaiiL7NoxjaTDSfgwuUzdJs1xX7Da0XX1vzIBKtfQyjdENeD2AnL/6uLCFZw
	b45cyptYMEX6eTDus3jZ3KpLWF7B9Ag==
X-Gm-Gg: ASbGncsq94SYbp95ff3+tameCYArGx0qEPeIbfEgKwJiNQI5NG6NWifPv1zGBVkGpFb
	SgpfnzoEF9ncwbpoSKd6appm4ukkb4RyvnSgfND8ldUVVCTGRsaitN2RJISvqyIO4vofd3xWO9S
	N0DWDJGNOz71bb/O7tMLaK8bcnFUUP70O7fFavFJ/33L9fLEwPz4o4
X-Google-Smtp-Source: AGHT+IEUcnO1jmBkpjLAeGTpq8tmGx447D3aaR02AaEi+9Z2G+kAuh4NYaIb9f9AZxSgqGWSKOIpi8Kxlb+3RtHqSDs=
X-Received: by 2002:a4a:d34d:0:b0:603:f521:ff26 with SMTP id
 006d021491bc7-6083339b557mr1829467eaf.1.1746704001799; Thu, 08 May 2025
 04:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508022839.1256059-1-kuba@kernel.org> <20250508022839.1256059-2-kuba@kernel.org>
In-Reply-To: <20250508022839.1256059-2-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 8 May 2025 12:33:10 +0100
X-Gm-Features: ATxdqUGPbsBNo7Jd0rQUSrljuSsObn9ROrSRHSPFZb4n0Yt3hol68OWbJxnZJIo
Message-ID: <CAD4GDZzR7DV-z7HA7=r9tmXmgkQu30K5QE9nAdz2eZfvKPOusA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl-gen: support sub-type for binary attributes
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 03:28, Jakub Kicinski <kuba@kernel.org> wrote:
>
> @@ -516,13 +516,21 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>
>  class TypeBinary(Type):
>      def arg_member(self, ri):
> +        if self.get('sub-type') and self.get('sub-type') in scalars:

This check is repeated a lot, so maybe it would benefit from a
_has_scalar_sub_type() helper?

> +            return [f'__{self.get("sub-type")} *{self.c_name}', 'size_t count']
>          return [f"const void *{self.c_name}", 'size_t len']
>
>      def presence_type(self):
> -        return 'len'
> +        if self.get('sub-type') and self.get('sub-type') in scalars:
> +            return 'count'
> +        else:
> +            return 'len'
>
>      def struct_member(self, ri):
> -        ri.cw.p(f"void *{self.c_name};")
> +        if self.get('sub-type') and self.get('sub-type') in scalars:
> +            ri.cw.p(f'__{self.get("sub-type")} *{self.c_name};')
> +        else:
> +            ri.cw.p(f"void *{self.c_name};")
>
>      def _attr_typol(self):
>          return f'.type = YNL_PT_BINARY,'
> @@ -549,18 +557,46 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          return mem
>
>      def attr_put(self, ri, var):
> -        self._attr_put_line(ri, var, f"ynl_attr_put(nlh, {self.enum_name}, " +
> -                            f"{var}->{self.c_name}, {var}->_len.{self.c_name})")
> +        if self.get('sub-type') and self.get('sub-type') in scalars:
> +            presence = self.presence_type()
> +            ri.cw.block_start(line=f"if ({var}->_{presence}.{self.c_name})")
> +            ri.cw.p(f"i = {var}->_{presence}.{self.c_name} * sizeof(__{self.get('sub-type')});")
> +            ri.cw.p(f"ynl_attr_put(nlh, {self.enum_name}, " +
> +                    f"{var}->{self.c_name}, i);")
> +            ri.cw.block_end()
> +            pass
> +        else:
> +            self._attr_put_line(ri, var, f"ynl_attr_put(nlh, {self.enum_name}, "
> +                                f"{var}->{self.c_name}, {var}->_len.{self.c_name})")
>
>      def _attr_get(self, ri, var):
> -        len_mem = var + '->_len.' + self.c_name
> -        return [f"{len_mem} = len;",
> -                f"{var}->{self.c_name} = malloc(len);",
> -                f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"], \
> +        get_lines = []
> +        len_mem = var + '->_' + self.presence_type() + '.' + self.c_name
> +
> +        if self.get('sub-type') and self.get('sub-type') in scalars:
> +            get_lines = [
> +                f"{len_mem} = len / sizeof(__{self.get('sub-type')});",
> +                f"len = {len_mem} * sizeof(__{self.get('sub-type')});",
> +            ]
> +        else:
> +            get_lines += [f"{len_mem} = len;"]
> +
> +        get_lines += [
> +            f"{var}->{self.c_name} = malloc(len);",
> +            f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"
> +        ]
> +
> +        return get_lines, \
>                 ['len = ynl_attr_data_len(attr);'], \
>                 ['unsigned int len;']
>
>      def _setter_lines(self, ri, member, presence):
> +        if self.get('sub-type') and self.get('sub-type') in scalars:
> +            return [f"{presence} = count;",
> +                    f"count *= sizeof(__{self.get('sub-type')});",
> +                    f"{member} = malloc(count);",
> +                    f'memcpy({member}, {self.c_name}, count);']
> +
>          return [f"{presence} = len;",
>                  f"{member} = malloc({presence});",
>                  f'memcpy({member}, {self.c_name}, {presence});']
> @@ -672,7 +708,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          lines = []
>          if self.attr['type'] in scalars:
>              lines += [f"free({var}->{ref}{self.c_name});"]
> -        elif self.attr['type'] == 'binary' and 'struct' in self.attr:
> +        elif self.attr['type'] == 'binary':
>              lines += [f"free({var}->{ref}{self.c_name});"]
>          elif self.attr['type'] == 'string':
>              lines += [
> --
> 2.49.0
>


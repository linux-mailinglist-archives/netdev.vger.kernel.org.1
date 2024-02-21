Return-Path: <netdev+bounces-73777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832B985E52E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E161F24506
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5E84FD2;
	Wed, 21 Feb 2024 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNOeGkj1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527142A8B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538874; cv=none; b=dAOUz+UgX0cw+VCV8Goqa0QsRazWTb0qOpIdQhUJmR4iO6WgKu4G1QWwTFXjJhbT3KQSFd5UG/xLBffCcvclSRKMQjzxMWnuuxxChSwY7dpW4MRYFUf0P36YIo3DbEWMCV4xQDET/0EvOD8eZ8ASHlUWWqw/gdT+ndfiZraajHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538874; c=relaxed/simple;
	bh=DMICXlKMP2RYfampGVlikZGkNDvg6Lw0KWxocK9ATB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCqM3kqO4w4Of2wvMyPAxPas52VH4jRHcc/iF9cXa+5ItvxvMHlHFinF9GlTcAOjaErAG4mzjONQSE4CxVdcNmHChQjMdalpbrLC/JZcIL/F+IbVWjfqHLidFUF17WEpF6LS6gSqy7wTN0+u9iABAojjLW3m4SUaNsNocx6wwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNOeGkj1; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21edca2a89dso1904461fac.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708538871; x=1709143671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OxE3Bos7oK6kz6ifkPSUgHs3Dvi8QLoEJoQEeSLCpgo=;
        b=gNOeGkj1wl8JY9wbH2m2kG6hnM9l7raJ2PubkoxvXoJydFFp3c3+GyQwmx4QJxoD30
         9XRiDZIk1zJbq/ziXYoI/ToV53fyjCpki9IgFTp8LZvCmXiirXqa/11APMYMLVABkREs
         1jXPAVnfatrphQ8vHgE151QQnM8ikd+bbJC+iO51sLp8smLrQwsUCfYtjIIXRqF61Kug
         G24DA1e/YzZFiRab9LRB0+fSX4ZQhI+0Qvvr50GU7KGHbNFTlNOjeT6lCbSk46XU1J0j
         B61xzw546eQ1LtDJLpcNmKTADPBEC/BcvdZVeBQM+SSHwbkNKU8KD6P1KAx3UAVgus7m
         EpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538871; x=1709143671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxE3Bos7oK6kz6ifkPSUgHs3Dvi8QLoEJoQEeSLCpgo=;
        b=BnUw/Ni1OHoIpYnuLxYRaelwS/Eq+P+zXd+s+uEYYUyXU/NJikFla9DMvG+ANUpjmR
         OOnm0/NwkbhTRM/SzjKS/jmm1SUdQmpnLQAV/ldTBddxQ3BCaspCSyHFcRex38zwFF2Z
         QKSx5ka3r940t+Xm5mIfP7ZYHS/fhZkbyr22zJ2BU3BaB4eDbUDYY1U/CiGqsnxzkC0M
         T6SQ1nbsdh0HlKASCtqjzDcPU6d4ieM88u+6pSOxfnYwAXf9AkIqawVov+dERAKPcW9L
         3MD3MVhCGA934ehSI6DnVzar06JDwEIKpIaSIplepOp9NRxK5Ny87J/M4SddaJ6+/1Xu
         FrBw==
X-Gm-Message-State: AOJu0Yz8pLhZBlQqU1dmuJbCdvZ6wFgLlvB4TsCYo1y2HHBqIgdto86j
	s95uHeb//DgnSFkHYQw1dg0x1buigSEdYEok05j6CkYGfHRUw5VWGiMLju4Z8lMG3RXz8eXkIrT
	cECzxWu7p+U2D1lhrR5LD2vxVryA=
X-Google-Smtp-Source: AGHT+IHh7/krQWo4Q8nf9c3BXsHjSTMpJJyyye3W2VWE7raAxXMPatZNJAVwa8CTd+3CDa/zjOvcHz7kGH/PBSnpNt4=
X-Received: by 2002:a05:6871:878d:b0:21a:33d2:849d with SMTP id
 td13-20020a056871878d00b0021a33d2849dmr21476615oab.11.1708538871335; Wed, 21
 Feb 2024 10:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221155415.158174-1-jiri@resnulli.us> <20240221155415.158174-2-jiri@resnulli.us>
In-Reply-To: <20240221155415.158174-2-jiri@resnulli.us>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 21 Feb 2024 18:07:40 +0000
Message-ID: <CAD4GDZxn7bq0t59=V7AJ_aFsJNvkdK_CJmnaPV2W_7uiEUozKQ@mail.gmail.com>
Subject: Re: [patch net-next v2 1/3] tools: ynl: allow user to specify flag
 attr with bool values
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com, 
	swarupkotikalapudi@gmail.com, sdf@google.com, lorenzo@kernel.org, 
	alessandromarcolini99@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 15:54, Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> The flag attr presence in Netlink message indicates value "true",
> if it is missing in the message it means "false".
>
> Allow user to specify attrname with value "true"/"false"
> in json for flag attrs, treat "false" value properly.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - accept other values than "False"
> ---
>  tools/net/ynl/lib/ynl.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index f45ee5f29bed..4a44840bab68 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -459,6 +459,8 @@ class YnlFamily(SpecFamily):
>                  attr_payload += self._add_attr(attr['nested-attributes'],
>                                                 subname, subvalue, sub_attrs)
>          elif attr["type"] == 'flag':
> +            if not value:
> +                return b''

Minor nit: It took me a moment to realise that by returning here, this
skips attribute creation. A comment to this effect would be helpful:

# If value is absent or false then skip attribute creation.

>              attr_payload = b''
>          elif attr["type"] == 'string':
>              attr_payload = str(value).encode('ascii') + b'\x00'
> --
> 2.43.2
>


Return-Path: <netdev+bounces-155474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5B2A026C9
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 080007A1720
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015CE1DE2DE;
	Mon,  6 Jan 2025 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAkVSWci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27D1DDC2C
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170731; cv=none; b=mV0brJBFrk50+9tCR2RnENuf6fRzrDvFBW89qGqmIs+j7Ra+x2oksNob8XW96r/Ae85dB++WBx4VuxPnCdQ79QxiZIuIIopQ5ntOBtPYYaFSeVYWGJplw7mDkpePvb/6tl5kRzGcz8VNA3tL8o92/+RGwP6QvCZnApW85cllU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170731; c=relaxed/simple;
	bh=AoGKTdQLVp8lJs6KEsJ42blCHX+O+ra67x+rL7NUhF4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=rDSPZtlE/aDA3yOiC0VRyrjPtII9X8gzNMQUnKc98kR2vo9gEnSbLIy1xSng33P88KnrSMkS/G0HHaZVQ/I9/UUvjx4nXm5Oo28R5B1lvixaPBlcbNbfFhZSHx1665g9xHiauWXjf9+89k5f7qF/hzMEV/AW/75u20p6k7r8I/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAkVSWci; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso95467675e9.3
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 05:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736170728; x=1736775528; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JQcall8YBT6kQHzDiZLCmN9lwpZ1+CiYpKkrMuaycdM=;
        b=NAkVSWciRm8+RYxLvWLdCv7mtKD7pO9HcH87kmVv0/O3ON/aLCWBMpbjm1uQR+0gVF
         NJz/cthFnDEno6vlAuj7VDWStutDkbRAyxLec8ihBZoUXWt7kxTv2oXLXqBHKNhLkcNl
         mvoaUOnr8Gicm9MTbGC2z6q+PJB1EX0fwWox7pRWc135iQXSBLQxe/ySxTRyCqHt9ECU
         DWbjgBmzNcdXpPVZbUQJ+eRgbVtNdy6mZ0w2b9k8Mk70SnFeLftVP9dG4rxMHBNcHC8t
         yZ+XzvwsBZHbKFt950TMzFXyLU8QERR5/ThX2h/LELzUUevfya/PGpeKxQgWBa4kSUKQ
         +JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736170728; x=1736775528;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQcall8YBT6kQHzDiZLCmN9lwpZ1+CiYpKkrMuaycdM=;
        b=PH9jHTneU1wC4cgE14Hn2eRaOeMdvx6XPWb3cTiZy8wHtG/QF0Y8djyRZ0AP9I+sWg
         x2xfdCDv4ABB2vymK4VblvmdVF9UrQhQ5j7CMsybjp2hkXp5LrxtljK/x5ay04giwU78
         vw3FagdgPr0E6XYO+YBKqYRIWkntvBKqtExwZ3JRx57EUQTNtfKyf7cFxkh3q+uaD1HZ
         9VDScfVJH1BkWxoxwRTYVVDKLPIYSCfidzoq2HmQtQWbp4VxSDsQmr343nC8T+8MSNgF
         OqovuGZ+Uq44lg/HmMOtR2D5sY9CDvy21/dt0e1wGoAzN9Q/r0TogYLupwlVbWS3R9xz
         DNzA==
X-Forwarded-Encrypted: i=1; AJvYcCVY7yBZ/hLhAPa4WU22rOjP+b6c0DotVE6XjMO4LHclAxzUneLXXQqOsJhfl/ms6/uByhBKRXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJyToL1oUGem2qcmRQbA+4VWK5G+lR6PRJ2GUa3nj+1egF7Mfy
	k+zmSGCP0xwiyFH6aiAEerR4DrFwDuv6d8vUGohCUAv7bLegziv1
X-Gm-Gg: ASbGncvxpdx3q68NbYiyzYfV7+eHjRYgnOHmx70eaorwOKWpMm4fwVxp4PGz2Pk8BWF
	XOb2AmIUTiCz6ndzpCUNpyWk5Em2CLYMPAPVfH6ulQUhRuaC8EDg4lvQzX7WFYBBBI7L4/Se2dT
	oWI87MxTH7Vp4BVisqpccUUY/mZgc1fk0r9Tk/c7ECfIiSwOuT49TjhmJ+7nWIhopLOY5gHKxhb
	afqlayKgHJIjSHTOdrAzpthMxKhiud9daIo2RSv7Oc57jOE7YCtRu0X9b8tdW0y/s0EUw==
X-Google-Smtp-Source: AGHT+IF+X7lx7ZFr9TNE1kYeLyoJxP7TXVFmGNRMTZXExN+lyx1rDoO+1Lf48l9un2VqqR8SgMS/Tg==
X-Received: by 2002:a05:6000:471a:b0:38a:69a9:afb1 with SMTP id ffacd0b85a97d-38a69a9b17amr9274383f8f.0.1736170728232;
        Mon, 06 Jan 2025 05:38:48 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:d10f:360f:84a5:c524])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2d2sm48642705f8f.71.2025.01.06.05.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 05:38:47 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 1/3] tools: ynl: correctly handle overrides of
 fields in subset
In-Reply-To: <20250105012523.1722231-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Sat, 4 Jan 2025 17:25:21 -0800")
Date: Mon, 06 Jan 2025 13:27:49 +0000
Message-ID: <m2a5c4nkbu.fsf@gmail.com>
References: <20250105012523.1722231-1-kuba@kernel.org>
	<20250105012523.1722231-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We stated in documentation [1] and previous discussions [2]
> that the need for overriding fields in members of subsets
> is anticipated. Implement it.
>
> [1] https://docs.kernel.org/next/userspace-api/netlink/specs.html#subset-of
> [2] https://lore.kernel.org/netdev/20231004171350.1f59cd1d@kernel.org/
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I guess we're okay with requiring Python >= 3.9 for combining
dicts with |

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> ---
>  tools/net/ynl/lib/nlspec.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
> index a745739655ad..314ec8007496 100644
> --- a/tools/net/ynl/lib/nlspec.py
> +++ b/tools/net/ynl/lib/nlspec.py
> @@ -219,7 +219,10 @@ jsonschema = None
>          else:
>              real_set = family.attr_sets[self.subset_of]
>              for elem in self.yaml['attributes']:
> -                attr = real_set[elem['name']]
> +                real_attr = real_set[elem['name']]
> +                combined_elem = real_attr.yaml | elem
> +                attr = self.new_attr(combined_elem, real_attr.value)
> +
>                  self.attrs[attr.name] = attr
>                  self.attrs_by_val[attr.value] = attr


Return-Path: <netdev+bounces-232924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9543C09F03
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 21:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BBB54E7846
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959DA2FF140;
	Sat, 25 Oct 2025 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LRGQFGkH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BCB262D14
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761419154; cv=none; b=MAGYT5WwFib6U6uzG3nm6CwKy7u8NCotq0NOmOk8Qbm8HN7cqVNvp5L3QuiSF0PAqj39JbuVwJMD7oJweLTF8pLs+/i6VJ/khIRm08oLJ17v3rE3zIQITAMJO3pl23rg1lY/lg7wf/e7FB0fdNEpXXiriR45I/lI6v7PW7y7DKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761419154; c=relaxed/simple;
	bh=QvyZICTf9FuxQ8mWjx0QX3lhGh3Fslv59FjCT6AFozA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6XUQbLQv53rjqLsbz8Yosrw4KbbAW243BIkYQyz5QpJX1TfaCSk2v8W+TtoZKHff52xNuELwxvBYRZ+IIf8Ztxv1f/ZF/3po+EYtoAkOj3Ay/s7v9NOlChyUcllGGVkXt3EgysRriJE92lYF0vvDlbtg1EHRNyo6capffbDb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LRGQFGkH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so4920471a12.2
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761419151; x=1762023951; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSxzgtX5p9C12ZyMkfzdovun4QYzTbltryBiUksXiZU=;
        b=LRGQFGkH8iyuQT1e8PSlUWBUPBEW7A2PjxpsGZs1SNjDcm4YfSU+o2T4rowZr1cBod
         tRr7JSd6w12bXQnGPkONSunDdkmbOlfFQqxH+zoOvRw2RRWSk/g4lwqiVPZae3HNVgUQ
         fFQ8zlPqei8K+pHNcHZvNTVZ5eQBTM3OxNgxYEY4Uu98GVRo97VauI9oXSWJKd3mRcQP
         +w1+JJOiVAp4ksJKujuD3ORJvrh7KAv7w8fhWaOyM2zB5UJXlHuN7fb+9uBXfHonj0fE
         tIr3GAAJhI0aL55K8X+fZrHxjUjBQ216WcxEmFT8sYYghUiUU+EIHg0MwskcDU5FzjPZ
         u4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761419151; x=1762023951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSxzgtX5p9C12ZyMkfzdovun4QYzTbltryBiUksXiZU=;
        b=Nbx3yPHb7wky8NEqpvAfI552MYtfRt/j3pQzkB71AyXCiHpXJXpMsMcqTVR6j+hm9v
         lwujTISNxIdr3JBaABZnJ1x1S1RCtvvbrHPyK2TG7fj1ByTgFZjWCwO9RP1m+ADAaPAe
         rHiLbiKQ8DeYWk7cuPJUoNfXZlDDsgvndua9LyXwaF4SKAhVZMPTzKm65bISx4cl+ZdD
         rZ7/Wb4lLzQVmcsEiXgb3zk/zOhHFRpPgXftV3hOJjO36UPggMA5rKyTCApgxkA8pXFF
         DtzCBrH0UIiI9zREUj3juadvJd6nh1gYzwuRtpz67SfHPAfWbgYtXmfhqeVugH6mfGCr
         mOPA==
X-Forwarded-Encrypted: i=1; AJvYcCW8g8FLNOEa31vWp0t+hPl9ExpEZSrz2WXJGQvM+WBaSAW152NUvanLe/ad8MoeWctuK/eWcNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJw0TNuAT241rjmjZ4gYEEloC8wiJ0x3N2hW74lLhZl2ES6Xq
	bS8rg7+hgD/7OJTP37fGH0PWuISupItLkQfxWvDkTay9JjyCF6udxe2i
X-Gm-Gg: ASbGncvv7mvo3DCN43iCpkf/7gq4egGYoLI+wU5iEw9Nf7Cczhe6N6edcMSWhL+2Zl8
	OpEkzXKlN22/BXVQrBlIPx37zmEZ/aIQ+c1WTV2cfDVVbYuoSlujjmlSNNRg/5HwhRy/2XpqcEc
	yV0SPI08WJ8irE8fSYFfA26OWpHgn6+myR4APeMch0vBU+hwawvnq/I7HZvvaPHrAyp+KbJN79d
	BcfO6G21BeFhLvfFYaMtotm9vOBJyFhPF6PdaaOHfQYL4gvlnTjBsRI7nI6Xq8gF/bHsOHSBGkO
	HXJjpE5rwHFNB3xhl18Ek4NdOFCWA147O2PRpRQ6Fw/UKvaFxoPg0KlNEf2oYju0kYhk7OfROPU
	4zZm4ahHwkl8gTbqyWZPOSRGgyqitOtnm0H1gE2e1Yn2N6YUxGyn96rjmGwlusdcTjWGetxZ+39
	VApzdSvbpK685PlxVfJeDK8IYO1aEir25PfVt1qR6KFqE8E1/6QFH5NYMsHtmuFkY=
X-Google-Smtp-Source: AGHT+IHYSOzw/CVH1J6dDf6O/EgqF2/+CNMP71U+fRJ7r8RPe0asFBz464lmBI6RmhSLw+vAX7J2cg==
X-Received: by 2002:a05:6402:1456:b0:63c:4537:75a7 with SMTP id 4fb4d7f45d1cf-63e60088ba1mr5742720a12.28.1761419150409;
        Sat, 25 Oct 2025 12:05:50 -0700 (PDT)
Received: from tycho (p200300c1c7311b00ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c731:1b00:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef8288asm2255823a12.10.2025.10.25.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 12:05:50 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Sat, 25 Oct 2025 21:05:48 +0200
From: Zahari Doychev <zahari.doychev@linux.com>
To: Petr Oros <poros@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>, 
	netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>, 
	Michal Schmidt <mschmidt@redhat.com>
Subject: Re: [PATCH net] tools: ynl: fix string attribute length to include
 null terminator
Message-ID: <dqevhqjn5fa2p6v5c4tqjup2hmqndeyemd6bnqssbe2oddaws2@azuqby7offil>
References: <20251024132438.351290-1-poros@redhat.com>
 <20251024170347.2bd06bf0@kernel.org>
 <CAPR2-9=UeTLfqWbfX+NcLef0BQ_xbKq7MJgt4YsjMi==FWZD-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPR2-9=UeTLfqWbfX+NcLef0BQ_xbKq7MJgt4YsjMi==FWZD-Q@mail.gmail.com>

On Sat, Oct 25, 2025 at 08:43:27PM +0200, Petr Oros wrote:
> Yeah, that must be it.
> 
> Regards,
> -Petr

This fixes my problem as well.

thanks

> 
> Dne so 25. 10. 2025 2:03 uživatel Jakub Kicinski <kuba@kernel.org> napsal:
> 
> > On Fri, 24 Oct 2025 15:24:38 +0200 Petr Oros wrote:
> > > The ynl_attr_put_str() function was not including the null terminator
> > > in the attribute length calculation. This caused kernel to reject
> > > CTRL_CMD_GETFAMILY requests with EINVAL:
> > > "Attribute failed policy validation".
> > >
> > > For a 4-character family name like "dpll":
> > > - Sent: nla_len=8 (4 byte header + 4 byte string without null)
> > > - Expected: nla_len=9 (4 byte header + 5 byte string with null)
> > >
> > > The bug was introduced in commit 15d2540e0d62 ("tools: ynl: check for
> > > overflow of constructed messages") when refactoring from stpcpy() to
> > > strlen(). The original code correctly included the null terminator:
> > >
> > >   end = stpcpy(ynl_attr_data(attr), str);
> > >   attr->nla_len = NLA_HDRLEN + NLA_ALIGN(end -
> > >                                 (char *)ynl_attr_data(attr));
> > >
> > > Since stpcpy() returns a pointer past the null terminator, the length
> > > included it. The refactored version using strlen() omitted the +1.
> > >
> > > The fix also removes NLA_ALIGN() from nla_len calculation, since
> > > nla_len should contain actual attribute length, not aligned length.
> > > Alignment is only for calculating next attribute position. This makes
> > > the code consistent with ynl_attr_put().
> > >
> > > CTRL_ATTR_FAMILY_NAME uses NLA_NUL_STRING policy which requires
> > > null terminator. Kernel validates with memchr() and rejects if not
> > > found.
> > >
> > > Fixes: 15d2540e0d62 ("tools: ynl: check for overflow of constructed
> > messages")
> > > Signed-off-by: Petr Oros <poros@redhat.com>
> > > ---
> > >  tools/net/ynl/lib/ynl-priv.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
> > > index 29481989ea7662..ced7dce44efb43 100644
> > > --- a/tools/net/ynl/lib/ynl-priv.h
> > > +++ b/tools/net/ynl/lib/ynl-priv.h
> > > @@ -313,7 +313,7 @@ ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int
> > attr_type, const char *str)
> > >       struct nlattr *attr;
> > >       size_t len;
> > >
> > > -     len = strlen(str);
> > > +     len = strlen(str) + 1;
> > >       if (__ynl_attr_put_overflow(nlh, len))
> > >               return;
> > >
> > > @@ -321,7 +321,7 @@ ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int
> > attr_type, const char *str)
> > >       attr->nla_type = attr_type;
> > >
> > >       strcpy((char *)ynl_attr_data(attr), str);
> > > -     attr->nla_len = NLA_HDRLEN + NLA_ALIGN(len);
> > > +     attr->nla_len = NLA_HDRLEN + len;
> > >
> > >       nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
> > >  }
> >
> > looks familiar...
> >
> > Link:
> > https://lore.kernel.org/20251018151737.365485-3-zahari.doychev@linux.com
> >
> >


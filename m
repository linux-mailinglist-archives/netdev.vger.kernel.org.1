Return-Path: <netdev+bounces-137054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC49A4256
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93041F25142
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EA12010EF;
	Fri, 18 Oct 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWrLNEcF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE51FF60E;
	Fri, 18 Oct 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265297; cv=none; b=iNcrsU+9XyYrqLCxi6lP47qPML2BAOpER03UmV/2yCSu910YN2Jkec88NMDmSNjyoQMqYB08EsmJc67HRMau+GdT+FdfGmUXvFAkPy8YKukTR4W4HsJ/QB1R+kns0+UPHuKkqc8lf1mv3ha6VKzU0da0IOB8C6K9midiZ+DMjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265297; c=relaxed/simple;
	bh=YZKKYRGzsoIWXeTycJrl7Ym6rcw4llKYY7TsD3bsasA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3IdEylZQptachx+ollOXPR0h0TWsbxHST2FZA5VA1fQZfjSoJU3cCGtO4ucDT4WuB37ZQQ57FcngE/R2qS8t8q+mpOpKYkCxJBKdNWSZ8s4XoEA2CUlJ3IpRgGfj7q7fB2jQdalysdXK8Q76aGOpNyhHsyUNpEJ911zxiKXvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWrLNEcF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c5ab2de184so12689316d6.0;
        Fri, 18 Oct 2024 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729265294; x=1729870094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMLrw4HNmWw7HnpVBfZMD9uoafD99fr6SDRKm79kUdc=;
        b=IWrLNEcFBQeEfXps6AlRstBi49AuuHJqD/GSa/yfJJccZWNbT4cnsSmxYNomZfmaJb
         p2KGY/jAcjQsgpnjfeYaCSLmMcoPSu1iKAohcozSk7goGHY60+tLkPzqhJUpPSLixjwp
         4b2JKNG3U3n7Hg1Va+kccu/OnOInimZAXfqY/o21SziAnOvUo/pwDlZKooGEUsL1m8ek
         YUpkiRYGkvnZMZAC6IrHSlmrzlLdmcDYL4iYmz2OQnOmCddxOiGUzCJka0EOEBm3VkBT
         i1Ylrw+QQ+TdjgCMJ6Q/jTpUH51iqJJdnAhJIUnBUTuXyHMds2nW37BT6tq9UUESmjeu
         JN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729265294; x=1729870094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMLrw4HNmWw7HnpVBfZMD9uoafD99fr6SDRKm79kUdc=;
        b=O7fR0NFJnUqAoOz12rjrSe/OJ+W8ZadhAZSmXcmqydGSXGwtiZZ9d2LfS2/aPgLKV1
         mb4OmVjX1z3Yh74XkXz8r9qH8BZDLa5m9LVodGJ0j2wwE7mu2wqY/PwNkH2/Pof+loFA
         si3AhrXa/uvT0y+iEo2JQhnCYea8HT8e3yS4S9sRQNPucfJfEdEJY3aOm1pyLnadMjh9
         mIUCnP7Lg+NMFvwlgzOSZ7X+/pJA4EnFqWYprN2nUzSR4L2cB6iv/MvJiNGn076omGOe
         MWZYNMPTHhKookkhviETmIdwcnyPfnkGupGRN0NauD2kz3R6JMfyjEH3dxWI5jgVYfsQ
         bf3A==
X-Forwarded-Encrypted: i=1; AJvYcCVPAHP8GwyJgHowMT+ksZj7APR1/tD3mH5oox415U+tI9MMXMuWhs4dtOqhw1so+Rt3IYtl7qUtMnN3mFdP@vger.kernel.org, AJvYcCVar+Xi+9QmL88+v9xV6DPYyE/mZUH+KirBXSn4nlElzwdMOlmukVXjUlk+l0l1liC2HPEIEjUGOZI=@vger.kernel.org, AJvYcCWpKptYslP4ntpFDXzh42kSmo3ocSRay0bisKClq1IwZ2WX4QcYy50C0bVneJLXQKuflyi9Wp8i@vger.kernel.org
X-Gm-Message-State: AOJu0YzUe85Z37SCEFuqqtq0B5r92D2JdrFAxcphiknU99c45po40Gjg
	n7Hzwd/VmNesjfIZziftuD6rMyhaPBvU3CVRvjUsEAHmV0LXQMg/C1pNEyExG9O3DVEBTVce3dB
	/zZ2115C8HV/MkbxZxXihgQ5lKL0=
X-Google-Smtp-Source: AGHT+IGSETQEs4eSkepn+zUai2IshkIhch+aMQ9rI7A/fqlblzg6d8g+HkJWavaQ+LnwNFnXWeQrxLnVBaezSqJPAVA=
X-Received: by 2002:a05:6214:4293:b0:6cc:8707:6ab with SMTP id
 6a1803df08f44-6cde15c7d32mr33169666d6.36.1729265294463; Fri, 18 Oct 2024
 08:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014135015.3506392-1-leitao@debian.org>
In-Reply-To: <20241014135015.3506392-1-leitao@debian.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 19 Oct 2024 00:28:03 +0900
Message-ID: <CAC5umygsk3NyPB99kdKtyV0xdpXihq-VRfzgua_8b40DexQ_QQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: Implement fault injection forcing skb reallocation
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com, 
	Pavel Begunkov <asml.silence@gmail.com>, Mina Almasry <almasrymina@google.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B410=E6=9C=8814=E6=97=A5(=E6=9C=88) 22:50 Breno Leitao <leitao@d=
ebian.org>:
> +static int __init skb_realloc_setup(char *str)
> +{
> +       return setup_fault_attr(&skb_realloc.attr, str);
> +}
> +__setup("skb_realloc=3D", skb_realloc_setup);

The documentation says "fail_net_force_skb_realloc=3D" boot option,
but this code seems to add "skb_realloc=3D" boot option.

I don't have a strong opinion about the naming, but I feel like
it's a bit long.  How about "fail_skb_realloc=3D"?

The same goes for the debugfs directory name.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>


Return-Path: <netdev+bounces-148337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 289479E12AF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 06:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DB1B22CB3
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 05:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842F81925AB;
	Tue,  3 Dec 2024 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID0h20OI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC9183CD9;
	Tue,  3 Dec 2024 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202462; cv=none; b=WeYkmkVfJKGQTqW1qIMigcqTRoCCIoRl5rvbGM1GUwwpsJf+hpVECaNm3hvrwGJvrzz4i1YHmRLytL4rjRU+oDJ0x4A0WG600ptl5Lu5gpeT0aTRFKtt7P2a56bJLWPov/G9vmDwYinym29JVMotaIKXoOCkGOLbFvEV5Sci05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202462; c=relaxed/simple;
	bh=olrZUa/l6HYqHwYXrLNl0NTJ3ENoGhzCoDL6AAfCL74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTqBvGR7/2I3PvQVaMSAmctukK+vOQrwmQFMVc8Zazgtj2y8s1m5e5F+C4duk6nANgizAgWLuqjxYH87Wp+OsGt5NQV8aefxROLNjaYcb+x5AkdCHKNFK5FTXRqh/FptYOiKNtjiXM+nZZqDL4U5Vx2YzTLyy/iQV3uW4C7OKOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID0h20OI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7250c199602so4224903b3a.1;
        Mon, 02 Dec 2024 21:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733202460; x=1733807260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UuKlkmtsz2rNevWll5uRQcJimPYczbi6gifk4CNJf8A=;
        b=ID0h20OI2hjTTPLX8XlmDAYN20y0qs924ritBUULZqQ4rCVzHd1PHxyO0W1VnqvcQf
         L0D+sd8Eo31/omeHEbt7U92e1hX2QElftgViPAwnoZAnH1qj3kXTR4c4zHk7Mzij7Ud+
         GO785hwoef1ocO1Lzk6AiH1L3cx5+JDeGD4MpTKH7r3sJDhItC/qCmuiWrsX8iPOQ1PB
         euRcYAUhbCBqzkZL3TUg7urgDYhMhLDWa2116W5v+0LzkHRvw9va6lNLFmLKukhV4GNV
         THWow7t5qG2zlLNhJDDgBZsEnjhUmm5ARIu7/ouMkOKuGiUWZlvrOHb2AVYGDBK2ibia
         ntyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733202460; x=1733807260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuKlkmtsz2rNevWll5uRQcJimPYczbi6gifk4CNJf8A=;
        b=UmGUIVDCps6gD5Zdwg4mmy51CuatLKLCTzpVJzoRevN8bLKmbMEsRv+1hzGuyyCDM/
         pdFgcGsYF5dEz2ZxAvg8tO6EyHnCKLrkjj47OWnnCvPdwZKRHrvj+efqFuK1bMz8thDx
         +Jacv9KdS8kt93SnAWdsiI32VMLwUV8TTadkK+w1aRrLwkYUyklA+FA/AZ6h0fCi9LJ1
         8WmYFVw74QpsTG0Cxq8Gm1i5/MnPW0U1pygJGzh0nZCGPuJWuZ/7etLMa2o//52bGtjn
         g1sLtAmBdbmz5kTT4PJPQQwf1H4fp6zGKl9PXG66S9hsQf2Q1/QjILZe9/1n0gVyBF5V
         NCTg==
X-Forwarded-Encrypted: i=1; AJvYcCWDWYvKGAoAVgPSz1rYB88yKPSZ5KIhBpinasgf9f6WsWYuWB7RbGvn1/marQrpIuYzmz/fK49a@vger.kernel.org, AJvYcCWdwrhSq1yui42d/9/lVYbP8HS4iSGakxZh5y8X3tVjPenGg1Nzqq8C2P7kZ8crSZu9OAVrPbwfx4Q=@vger.kernel.org, AJvYcCXhG/lzLCoDNlDa1enuJ4dhzeo+/F3/Oz6F4efrQ3nZp2ro8V9IOtFp+E3B9WItEBPaN4WaXK6xsq5GiNFQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6xxGqbTIrivNwquXl9eZCkb+2MsPPDP+CYfOisFf77fmJgYo
	p5jN5TIMvUMWl5YnMZ2ADs5h9UMK2/3MxlwVbTkdi+dJZ1feRS8=
X-Gm-Gg: ASbGncutX1IxriID6GVJ0JloTn9iqzfGIHHD4tsNkxzqHL3lzTnYlm39ra9h+LYFaVV
	Go97fhCCXCU7uHUoKmZdq3lx/6Z+t8AN065/EXN5wyFLVgMhzORRnmu6tBZNm+ZvPxYq3bR1JX2
	+R1s/n32dNV3dtZelZ77H8BRmCFxirk4b5kWvQNqowmDL88PDXI7TtHPgzq6h02dTusxZqkd8P3
	qh4jcFQoIQr2hyxgUmRrH/3V8ZEPZCt0rqYoxYa8L+hUPYvQw==
X-Google-Smtp-Source: AGHT+IHIapbPNpE1JCSPINZu4GYWgbP7xezDiXQpr9UCEuts/wFFmZ3DvuGvpgu6vAW4nqwsIycUmg==
X-Received: by 2002:a05:6a00:2284:b0:71e:64fe:965f with SMTP id d2e1a72fcca58-7257fcb0b89mr1558197b3a.20.1733202459941;
        Mon, 02 Dec 2024 21:07:39 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c304fe2sm8779989a12.33.2024.12.02.21.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 21:07:39 -0800 (PST)
Date: Mon, 2 Dec 2024 21:07:38 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net,
	andrew+netdev@lunn.ch, kory.maincent@bootlin.com,
	nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3 0/8] ethtool: generate uapi header from the
 spec
Message-ID: <Z06SGszVaXopVlhR@mini-arch>
References: <20241202162936.3778016-1-sdf@fomichev.me>
 <20241202195228.65c9a49a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202195228.65c9a49a@kernel.org>

On 12/02, Jakub Kicinski wrote:
> On Mon,  2 Dec 2024 08:29:28 -0800 Stanislav Fomichev wrote:
> > We keep expanding ethtool netlink api surface and this leads to
> > constantly playing catchup on the ynl spec side. There are a couple
> > of things that prevent us from fully converting to generating
> > the header from the spec (stats and cable tests), but we can
> > generate 95% of the header which is still better than maintaining
> > c header and spec separately. The series adds a couple of missing
> > features on the ynl-gen-c side and separates the parts
> > that we can generate into new ethtool_netlink_generated.h.
> > 
> > v3:
> > - s/Unsupported enum-model/Unsupported message enum-model/ (Jakub)
> > - add placeholder doc for header-flags (Jakub)
> > 
> > v2:
> > - attr-cnt-name -> enum-cnt-name (Jakub)
> > - add enum-cnt-name documentation (Jakub)
> > - __ETHTOOL_XXX_CNT -> __ethtool-xxx-cnt + c_upper (Jakub)
> > - keep and refine enum model check (Jakub)
> > - use 'header' presence as a signal to omit rendering instead of new
> >   'render' property (Jakub)
> > - new patch to reverse the order of header dependencies in xxx-user.h
> > 
> > Stanislav Fomichev (8):
> >   ynl: support enum-cnt-name attribute in legacy definitions
> >   ynl: skip rendering attributes with header property in uapi mode
> >   ynl: support directional specs in ynl-gen-c.py
> >   ynl: add missing pieces to ethtool spec to better match uapi header
> >   ynl: include uapi header after all dependencies
> >   ethtool: separate definitions that are gonna be generated
> >   ethtool: remove the comments that are not gonna be generated
> >   ethtool: regenerate uapi header from the spec
> 
> Looks like doc codegen is unhappy about the missing type definitions:
> 
> Documentation/networking/netlink_spec/ethtool.rst:1122: WARNING: Bullet list ends without a blank line; unexpected unindent.
> Documentation/networking/netlink_spec/ethtool.rst:2126: ERROR: Unknown target name: Documentation/networking/netlink_spec/ethtool.rst:2131: ERROR: Unknown target name: "ethtool_a_cable_result_code".
> Documentation/networking/netlink_spec/ethtool.rst:2136: ERROR: Unknown target name: "ethtool_a_cable_inf_src".
> 
> We need to teach it to not link to external types?

The following calms it down on my side:

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index efa00665c191..859ae0cb1fd8 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -60,7 +60,8 @@ uapi-header: linux/ethtool_netlink_generated.h
     name-prefix: ethtool-c33-pse-ext-state-
     header: linux/ethtool.h
     entries:
-        - none
+        - name: none
+          doc: none
         -
           name: error-condition
           doc: Group of error_condition states
@@ -875,15 +876,15 @@ uapi-header: linux/ethtool_netlink_generated.h
         value: 0
       -
         name: pair
-        doc: ETHTOOL_A_CABLE_PAIR_
+        doc: ETHTOOL_A_CABLE_PAIR
         type: u8
       -
         name: code
-        doc: ETHTOOL_A_CABLE_RESULT_CODE_
+        doc: ETHTOOL_A_CABLE_RESULT_CODE
         type: u8
       -
         name: src
-        doc: ETHTOOL_A_CABLE_INF_SRC_
+        doc: ETHTOOL_A_CABLE_INF_SRC
         type: u32
   -
     name: cable-fault-length

The first one fixes the bullet list (seems like mixing entries with and
without docs confuses ynl-gen-rst.py). And removing trailing _ fixes the
rest (don't know why).

Any objections to folding it as is into v4? I can go on and try to
understand why ynl-gen-rst.py behaves exactly that way, but not sure
it would buy us anything?


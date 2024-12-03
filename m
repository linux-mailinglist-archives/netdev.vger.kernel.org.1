Return-Path: <netdev+bounces-148643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E7D9E2E07
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB869B25D42
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480711F8910;
	Tue,  3 Dec 2024 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPimEKq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20084A29;
	Tue,  3 Dec 2024 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255439; cv=none; b=UnMRRE/ahIfOFt8kqf3+qe6DDrIB1k2nnfoDbo/iP9qZcEl0efywo8mH/uLmYaIv5EHbo+T7VFVRusi4jLHwPL6NwDWe7egrjELJ44eonozpPmr7SmF8TRnaFaJohBgSZuKE7aQ8ED2ux4M77rgAySh5pwRknUfbzv29YlVbwGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255439; c=relaxed/simple;
	bh=kFlYwn6ayP5qqBDY6UmZrLnFtOzph21tXcwoPje9qE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuxOlJOH1q/J3TPoM6Tko9VXzDeey01Xl2dOBDVzAXws2b596N3R+sR2osgYAjteMJsVLMndMk8q5UfUWRpg46sPXY457+REGAZ6070TSEeJKiJ40xnak0MEG8iRpv7YN1CZDOvx9Xmqys1J2hCw/juxcwsmNOHC93dbRE9Zyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPimEKq5; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71d4994dfbaso87912a34.0;
        Tue, 03 Dec 2024 11:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733255437; x=1733860237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ifgqa+vTgRi8G8JNmUoN0vZKwQw99/lv6G+n2Nugids=;
        b=dPimEKq56111BDbvLE+MGdK3GwdK9p0l+SZ52TmorOfxISqLFzDygFXA3HFZLgra9e
         dI791q9qQFzrTFmZ/4sZ3Uoqkxnt9hrVwxw/XpDz5BTxC2eieIqUuVi7s/Iw+9OwFLUV
         e5Hasbc/iYv3GArgxqzWVDKHqfm+HMzzaMk3b2z40H37yd0mEK5oOybkxBYwQqa/52q+
         DRCaNeRp96ENLWNz3ybA4mUe95hrAQEDDzNFbnI/5WZ4UqWoEH07vN5b7gqpCdxlCvE+
         2dOFQR9rr3DGMNi4/qtfB/HNeU3KtHnOeh33GLZLXlfprX8X97RbnvukXrJ+WfZ6aQ3v
         Kdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733255437; x=1733860237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ifgqa+vTgRi8G8JNmUoN0vZKwQw99/lv6G+n2Nugids=;
        b=hY0GC3CdI8CSKjIgG0T8f0q8tFX5zelRoJJZzoTpegGAQhCmCuBFM/1bPok3mBtd4l
         eAp9GdpPl49sQ1CP1jXgXhl/uE+FcJw7ZU21Adatz7gf6k610GhWVUWWCsccmZVvDHl2
         JBP4aKB4Mo79QcIPaYW2jWGf7DZzRg6MyvC2QzucAyiTeK1CgSdgZvDGjHeyPN8e0Cso
         2NDkWkwBu70lCZHcGM7Qxk/ozAHXjD0pmJuNlJiIsdL361o/N2WSUeVbP4RwFehLy0sM
         9hQwmFaI10T59u5lhKGpQwv2mYSYs9kXb9pk0xztY2qBQ4olXwxqViOtv4Ws6f3bIqkX
         KsUg==
X-Forwarded-Encrypted: i=1; AJvYcCWDEIHCCxG3mrMODS/Hb5yCZcDRgj9+t6jjQnWTTd0k1iVJiY4vFQ3Vzdk5B5neh+xV3Pk0VaPm1ZYIEhI=@vger.kernel.org, AJvYcCXdSSmrTM3kWOfEycKWBQ9pydWlMd+NlxE8BsMAxEPN8B85emwB65IxWOzRY6H8hnG7hTqOPqer@vger.kernel.org
X-Gm-Message-State: AOJu0YzujOLiapAseSQZ38enFzMkrFY5i4NlMpkjz5XjAAjoai6/z+dU
	uKbDLnyPTIRxBz5z8ETuxSHdHA7S/ExQk4awmNFaRbvv7mhvu2vtBlBUELTBAzxK70/RDTP3VhQ
	FS4NjfUTU6fFOhG6mA71viK9k1LW7Irzn
X-Gm-Gg: ASbGncsdggmJDqZstQ0zE2FaKe16z2Lov31igIuPGpgRbcbAyxqt7WyCuy/MfFoepwi
	DF09NBZlnSBTb1Tl+T6xPij5REe9t8DORM83zVXhkxOgSZSAcKugVa17f9XvR
X-Google-Smtp-Source: AGHT+IHChxvWasxRatX3dpdatcYjYbz8GgvAB9LdIpIWz9KT8LLHO03VZpXRHfyCW77TBTi98NMNt2Aclsjno0yFydA=
X-Received: by 2002:a05:6830:630d:b0:71d:4d35:313b with SMTP id
 46e09a7af769-71daddab700mr2628814a34.1.1733255436713; Tue, 03 Dec 2024
 11:50:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733216767.git.jstancek@redhat.com> <20b2bdfe94fed5b9694e22c79c79858502f5e014.1733216767.git.jstancek@redhat.com>
In-Reply-To: <20b2bdfe94fed5b9694e22c79c79858502f5e014.1733216767.git.jstancek@redhat.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 3 Dec 2024 19:50:25 +0000
Message-ID: <CAD4GDZzY8YXY0Oszb0NP_=AwSEa-nEKxDwVKY3T7eqoo9uLkaA@mail.gmail.com>
Subject: Re: [PATCH 1/5] tools: ynl: move python code to separate sub-directory
To: Jan Stancek <jstancek@redhat.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Dec 2024 at 09:27, Jan Stancek <jstancek@redhat.com> wrote:
>
> Move python code to a separate directory so it can be
> packaged as a python module.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  tools/net/ynl/Makefile                    | 1 +
>  tools/net/ynl/generated/Makefile          | 2 +-
>  tools/net/ynl/lib/.gitignore              | 1 -
>  tools/net/ynl/lib/Makefile                | 1 -
>  tools/net/ynl/pyynl/__init__.py           | 0
>  tools/net/ynl/{ => pyynl}/cli.py          | 0

Perhaps we could have a symlink to cli.py from the original location
for compatibility with existing in-place usage. Same for ethtool.py
and other user-facing scripts.

>  tools/net/ynl/{ => pyynl}/ethtool.py      | 0
>  tools/net/ynl/pyynl/lib/.gitignore        | 1 +
>  tools/net/ynl/{ => pyynl}/lib/__init__.py | 0
>  tools/net/ynl/{ => pyynl}/lib/nlspec.py   | 0
>  tools/net/ynl/{ => pyynl}/lib/ynl.py      | 0
>  tools/net/ynl/{ => pyynl}/ynl-gen-c.py    | 0
>  tools/net/ynl/{ => pyynl}/ynl-gen-rst.py  | 0

The documentation build depends on this location. This patch is
required to fix it:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index fa71602ec961..52c6c5a3efa9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -104,7 +104,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath
$(BUILDDIR)/$3/$4)
 YNL_INDEX:=$(srctree)/Documentation/networking/netlink_spec/index.rst
 YNL_RST_DIR:=$(srctree)/Documentation/networking/netlink_spec
 YNL_YAML_DIR:=$(srctree)/Documentation/netlink/specs
-YNL_TOOL:=$(srctree)/tools/net/ynl/ynl-gen-rst.py
+YNL_TOOL:=$(srctree)/tools/net/ynl/pyynl/ynl_gen_rst.py

 YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard
$(YNL_YAML_DIR)/*.yaml))
 YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%,
$(YNL_RST_FILES_TMP))


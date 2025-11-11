Return-Path: <netdev+bounces-237581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC5CC4D5FB
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E729F3A05B2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F1F2FBE03;
	Tue, 11 Nov 2025 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4MQK7po";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pP6FIubD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5A2F7AA6
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859750; cv=none; b=LcPsZmFMakiW+tDSS+RVKdlxSqX3AWMFQ2w48lCwqlA3sDuTv0F3UjfTGPTY+dSVUnj45FqRfgVlC/3JgAn5950XXoXj2Jb+2ii10w9EhlGdQIvRAk9Ay2e/1ipmIvwukR01KPz3+72YDa19Ie9KyiiLC8GkeSJUGT/sz4/zGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859750; c=relaxed/simple;
	bh=+a3FXns3drOomy2losT83l+6yda8JsH6yzxl2Bi9LgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSri5YmWg7HEzbYXlcfTJjC/7UxZzvHYFWThTPwtxwMGu5h8Ld3rRiHoPOYss4oZth7DUPENYZO7oB1++3bGqV7yM07sRzhzapwQeNGaaEKpKDc+vEPXNNJL+Inb81ddfuS5diQt13ZrTt7kapPnPXcWCCWRF3L3cdt/yc5zdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4MQK7po; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pP6FIubD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762859747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Js25JqV/nrIrTu7LVkEMw5HQuj8XZ/095iAhtGHGsrI=;
	b=N4MQK7poxxdvYOx9qhTnj+EUmPW5MeMFnK58n26JxEDfrP4ng+0EuW7xhLb65Ag++FelAq
	WQGN7a7QblCBUjZWkdZnd7VbWSubMAnV6PpARO2z1GFaic6SJzbPEM76PwWOjVSqTURPFo
	QU33yHIYdAjZOGa6n9LePeBN93VsNUk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-dZqMtj09OtiKBsJgQHz6IQ-1; Tue, 11 Nov 2025 06:15:46 -0500
X-MC-Unique: dZqMtj09OtiKBsJgQHz6IQ-1
X-Mimecast-MFC-AGG-ID: dZqMtj09OtiKBsJgQHz6IQ_1762859745
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429be5aee5bso1865088f8f.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 03:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762859745; x=1763464545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Js25JqV/nrIrTu7LVkEMw5HQuj8XZ/095iAhtGHGsrI=;
        b=pP6FIubD3mfAgS9zY+WfLc/TM9QGJdtJ4mtqIkd2uY9nnTtpiMygmbGpkt+kDAJsk/
         9UNBMJtjW7s8krhcYCETkFV6aWCH+Ok7bGDbN4sqhZ6c157PN0msW5m5AKiBJi9kO2eH
         TyvvtI0iymAR4YVtkmDWjY6n+WO7dt5NZk8u9zmgTKK2qz7LAviF37OKuw6f6sKbRUwR
         PhXGZaKZlkvJ7+PS3wdQPnlc1nQLzt12awFy0FL6GmumIsTDY6aEtJ4ykFCUrJ8SDeoB
         of3jUTzshGdlgsnHNqAZzscBufc/pXa0iLpuT0wzDxrXI1B+Jina8GpJGZJijGIFSIla
         XAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762859745; x=1763464545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Js25JqV/nrIrTu7LVkEMw5HQuj8XZ/095iAhtGHGsrI=;
        b=C4uKFrURv98xsntIlHVnEkxH8gKCGn92j0sBMNsVyNonbMoa7Szh5M6sZiqRZX57nP
         hImejdk0Iij3niRyVtEbGX+Ovg0apEkPOg4+aorQfJ75GsXmpIliaXR66vBW0Mn/TWxV
         FZto0Z1SVl8+9f2ZgGHn414J7e7RDggnKs+iS3mgJ7D7UGyHtuZivkIVsPZNALN/1Ecv
         ld5olZeDvPJZZ1YYRymBvBunfF0BwSy03eXjNGaDQKyQAOG3T9dLxvgCiEeB/KcnyQEd
         V/XCpmf8n5wahKy23E+p+SrUQ0sgdZmJu/cT0StS28HxkD3LVLLyRh6JSO+rJzmlRrYg
         L9qA==
X-Gm-Message-State: AOJu0YxhZZjf9HQnkHiCYlacVPCd0eXt7f/S3IY07QnkLCkh515TaARd
	ZaEQaD0MKbljz+TP7wAFgPEn2v5G48Zm+8PdJoCPJqSZvDIEk41maC9ME8lWpiiNSdTq1r1uZVT
	9TLeI0ixBmtjKfNb2tySITTsyJbjHrfdO8gt2mK7nhKDgHNPuTjtATKVBJw==
X-Gm-Gg: ASbGncuIIHZDIE7zgVBWpNww6k1h+q57cIfJLGUqXx6muQRes6xWgD2uAq16Qt7Zg55
	mcBm6sWlnmlkWZsPFD4iKm6e8WfpbjhGY+k12GBdSYNkxDXwP6jbmjGj+MmP2mzIlY9u3jm8+Mi
	WM9dCH+Dc2z+dwMpEpQIziaMNBDgPmzpQZ9LISyB69RNXURUOI5xU3VUkYopORKluNAHNylDgtR
	KF/vPVttl6e85KCSgGAS3hZTzGzQiQUwux/Le1Y1WUsDsZo9WU3lbnsk/jztuWMyLirt+ugr3vj
	KD24ZU9TtBDdpNO8HXUhfqxBw0MHKPX2uSzmASyoth0DD7wXfZk7JryRy3N3tfIAwTQuVR4Xu+C
	0zA==
X-Received: by 2002:a05:6000:1a87:b0:42b:3ee9:4775 with SMTP id ffacd0b85a97d-42b3ee9654dmr5066665f8f.11.1762859745195;
        Tue, 11 Nov 2025 03:15:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5BmQVzCMGzSxTmdQQ5mIFBWicLh/gAll7NU+gJ69qiCBbPtixiG95p0b9x1OK2FuTFUowrQ==
X-Received: by 2002:a05:6000:1a87:b0:42b:3ee9:4775 with SMTP id ffacd0b85a97d-42b3ee9654dmr5066617f8f.11.1762859744784;
        Tue, 11 Nov 2025 03:15:44 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b35ad7c16sm14636974f8f.15.2025.11.11.03.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 03:15:44 -0800 (PST)
Message-ID: <1ebaa0e4-8d7d-4340-b1de-4cb1dcf60311@redhat.com>
Date: Tue, 11 Nov 2025 12:15:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] tools: ynltool: create skeleton for the C
 command
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 donald.hunter@gmail.com
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, sdf@fomichev.me, joe@dama.to, jstancek@redhat.com
References: <20251107162227.980672-1-kuba@kernel.org>
 <20251107162227.980672-2-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251107162227.980672-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 5:22 PM, Jakub Kicinski wrote:
> Based on past discussions it seems like integration of YNL into
> iproute2 is unlikely. YNL itself is not great as a C library,
> since it has no backward compat (we routinely change types).
> 
> Most of the operations can be performed with the generic Python
> CLI directly. There is, however, a handful of operations where
> summarization of kernel output is very useful (mostly related
> to stats: page-pool, qstat).
> 
> Create a command (inspired by bpftool, I think it stood the test

FTR, it took me a little to understand that for this patch at least is
"inspired" alike the notorious MS socket implementation ;)

> of time reasonably well) to be able to plug the subcommands into.
> 
> Link: https://lore.kernel.org/1754895902-8790-1-git-send-email-ernis@linux.microsoft.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - use kernel source version
> v1: https://lore.kernel.org/20251104232348.1954349-3-kuba@kernel.org
> ---
>  tools/net/ynl/Makefile              |   3 +-
>  tools/net/ynl/ynltool/Makefile      |  52 +++++
>  tools/net/ynl/ynltool/json_writer.h |  75 ++++++++
>  tools/net/ynl/ynltool/main.h        |  62 ++++++
>  tools/net/ynl/ynltool/json_writer.c | 288 ++++++++++++++++++++++++++++
>  tools/net/ynl/ynltool/main.c        | 240 +++++++++++++++++++++++
>  tools/net/ynl/ynltool/.gitignore    |   1 +
>  7 files changed, 720 insertions(+), 1 deletion(-)
>  create mode 100644 tools/net/ynl/ynltool/Makefile
>  create mode 100644 tools/net/ynl/ynltool/json_writer.h
>  create mode 100644 tools/net/ynl/ynltool/main.h
>  create mode 100644 tools/net/ynl/ynltool/json_writer.c
>  create mode 100644 tools/net/ynl/ynltool/main.c
>  create mode 100644 tools/net/ynl/ynltool/.gitignore
> 
> diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
> index 211df5a93ad9..31ed20c0f3f8 100644
> --- a/tools/net/ynl/Makefile
> +++ b/tools/net/ynl/Makefile
> @@ -12,10 +12,11 @@ endif
>  libdir  ?= $(prefix)/$(libdir_relative)
>  includedir ?= $(prefix)/include
>  
> -SUBDIRS = lib generated samples
> +SUBDIRS = lib generated samples ynltool
>  
>  all: $(SUBDIRS) libynl.a
>  
> +ynltool: | lib generated libynl.a
>  samples: | lib generated
>  libynl.a: | lib generated
>  	@echo -e "\tAR $@"
> diff --git a/tools/net/ynl/ynltool/Makefile b/tools/net/ynl/ynltool/Makefile
> new file mode 100644
> index 000000000000..cfabab3a20da
> --- /dev/null
> +++ b/tools/net/ynl/ynltool/Makefile
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +include ../Makefile.deps
> +
> +INSTALL	?= install
> +prefix  ?= /usr
> +
> +CC := gcc
> +CFLAGS := -Wall -Wextra -Werror -O2
> +ifeq ("$(DEBUG)","1")
> +  CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
> +endif
> +CFLAGS += -I../lib
> +
> +SRC_VERSION := \
> +	$(shell make --no-print-directory -sC ../../../.. kernelversion || \
> +		echo "unknown")
> +
> +CFLAGS += -DSRC_VERSION='"$(SRC_VERSION)"'
> +
> +SRCS := $(wildcard *.c)
> +OBJS := $(patsubst %.c,$(OUTPUT)%.o,$(SRCS))
> +
> +YNLTOOL := $(OUTPUT)ynltool
> +
> +include $(wildcard *.d)
> +
> +all: $(YNLTOOL)
> +
> +Q = @
> +
> +$(YNLTOOL): $(OBJS)
> +	$(Q)echo -e "\tLINK $@"
> +	$(Q)$(CC) $(CFLAGS) -o $@ $(OBJS)
> +
> +%.o: %.c main.h json_writer.h
> +	$(Q)echo -e "\tCC $@"
> +	$(Q)$(COMPILE.c) -MMD -c -o $@ $<
> +
> +clean:
> +	rm -f *.o *.d *~
> +
> +distclean: clean
> +	rm -f $(YNLTOOL)
> +
> +bindir ?= /usr/bin
> +
> +install: $(YNLTOOL)
> +	install -m 0755 $(YNLTOOL) $(DESTDIR)$(bindir)/$(YNLTOOL)

Minor nit: $(INSTALL) above?

Also possibly using/including scripts/Makefile.include could avoid some
code duplication? (or at least make the V=1 option effective)/

/P



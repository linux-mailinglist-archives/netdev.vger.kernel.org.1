Return-Path: <netdev+bounces-245625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7327CD39A1
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 02:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ECAF30080D8
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 01:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848314A91;
	Sun, 21 Dec 2025 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Bw4oET/y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28004186A
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766281117; cv=none; b=A3sEBporOn0ubM1mt+0yruQ2rRL95NZDCnr1vcDQp4gZip9obEq/oeCpsxxSKWrPUjm7okvyzRUfIx50YHgvcMG5TcNLCdVx6f5cnoSHvJkc8jiASjqQm6lJbPthFLz9WiJQKiULWMhkOOJCJR0DI6INqovCgmdCnysaJ4Uunt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766281117; c=relaxed/simple;
	bh=DJ3aJ/PFdIv4YbqOZKoxhRPeYjfCD8rQNqLg/LXvDU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJNUqmfw+N4Cj662S4/ykl+GfHiUTCsixs09v7IylEQOnBVS1+ligJ32Xclf0+qxDdViz+qZJlyzbcq32OzrcogzbRka6WdpFFI7s/a/dpWY4aK1Ijg1fT47zuVPU1Io9bQC/+JunUrauluoG2ESzWDyLzOuswYN4BjBHw7N+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Bw4oET/y; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso25087185e9.2
        for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 17:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766281113; x=1766885913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7sc7Xqukzy4yswbZhOsxvK7HvOddMT9h30cH6NAeEU=;
        b=Bw4oET/yMukDnzOu9uHJf6CFkms8bve3Ku4JzQXG3xe4YB6JUIMHwkwDw07PRqQIV+
         0loyocgYr4axwnE5Yf7a2BuXEpqkKw5iJG7TF6/uwHEbtzXYtSB6CErOY1YGkZvc9Nl7
         DBcZvI3f9JljJ/HL0nAByls++qlnFQq4he1QARYBTe5d9e+gXZOlwmvKQvdJSFFSUkMH
         18KNeN8etO3cMl6/cTF08/ia6q/RBZbWWw1jKNIRurY3swBJBBQudHv3kes34TGQfN4f
         lczjAWKSbCaTU7J3QoJk/6TF8XIHeuSoAjHjGW0GdKIJyL0Q3YOPm4XeE2vgjk3Dd6Sl
         lzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766281113; x=1766885913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7sc7Xqukzy4yswbZhOsxvK7HvOddMT9h30cH6NAeEU=;
        b=FLbAiRfLZQqqejnr1m3tOaOUUy+8XOJrxV8azkcCgmX9+DkttrEUKY5fPWgXR5rPNz
         BZF1dj5LjrOTwgM5QlzfQAwl0rDkzNAyjTu91nb060DXhIeuVPYTUXWs4rqoxMgKZKJv
         AkbdwxI17vwE0qfW7E0DC85UsD5RfGIQ6+pQeh0xXaOzYdnlM7txinxZyBiP7T8WaBsd
         MESalyhP1FZMDPSr0LBDKp7AN3h4rvf1a05YihbboDMTnwSUIQjQsznFc+aM0zDrTtRu
         i63Qyj4SaSqfRBXQAe1tJEqbycBrygfaa83ZOclEPf0BjztSvW1IISj1Pg4UOLdSbVsU
         l+5A==
X-Gm-Message-State: AOJu0YzSZEQQ+7mUxoSJLu6Ut14Kj+QnGrnldbZm1AnWooTdqJXy9ZIG
	5W7eEhTZ4+TtW/bPQ+F42pwEAivgMWBS8vnBP7cmqdzsuLrwu/EI1awCzge2pCaV9uw=
X-Gm-Gg: AY/fxX6M2Ee3yMtBjDNnjArV89XckuJ7lYkCpOjpfnHU5OR/u7P604RLKmJQvSpnZed
	bLMdjodebLGCXVIvGCGyOoeERok85BZVyXsYyLrQV7MK9GpQwI5Idb7hl5ias+1WGgybn4wol0M
	bNdqN0KbqS62yHxxn+hqaKeoVTzp88CFLVT3cqIDw4leLV64QBQnIF7DQRcA1qK5WH9q5Skxufq
	YSmkpd6OU6QDBJk7IJLJ2zaG4oxFbt1S51pgHaPI3ZPjXLS24BlzBWw74wRxnWYVN3nnMnfnKkE
	XQ9L/HO19svw0Niu7JN+YYJBjFAfgN1J8hHiWAoEtfearVUbCkJKZ+6jKPzp4U+808m4xxQp9ec
	NcBaA974lCg+mkEcN/HCB2OhrC8ODN1g3kpKbclRs0zCwOlGlVN4kqUeKlXc02RQqrFhhbuW6cK
	hxxqlRETVE16RcOIY51iArwOoXlmbJLTwqUBzF00PjhRrWzhpJtt2/
X-Google-Smtp-Source: AGHT+IGtjyZ74/SpfWOIdVJ2hw0RnBKHVwtZnk682zj+MYN14GSQqAgmbKtQhVyUFf8Nu80X8YK6CQ==
X-Received: by 2002:a05:600c:3b94:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-47d19566b00mr79678175e9.12.1766281112421;
        Sat, 20 Dec 2025 17:38:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d1936d220sm123164625e9.8.2025.12.20.17.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 17:38:32 -0800 (PST)
Date: Sat, 20 Dec 2025 17:38:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Masatake YAMATO <yamato@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 2/2] man: explain rt_tables.d and rt_protos.d
 directories
Message-ID: <20251220173827.5bc4e2b2@phoenix.local>
In-Reply-To: <20251217154547.2410768-1-yamato@redhat.com>
References: <20251217154547.2410768-1-yamato@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 00:45:47 +0900
Masatake YAMATO <yamato@redhat.com> wrote:

> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  man/man8/ip-route.8.in | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
> index aafa6d98..d30285a4 100644
> --- a/man/man8/ip-route.8.in
> +++ b/man/man8/ip-route.8.in
> @@ -1474,6 +1474,20 @@ ip route add 10.1.1.0/30 nhid 10
>  .RS 4
>  Adds an ipv4 route using nexthop object with id 10.
>  .RE
> +
> +.SH FILES
> +.BR *.conf
> +files under
> +.BR @SYSCONF_USR_DIR@/rt_tables.d " or " @SYSCONF_ETC_DIR@/rt_tables.d
> +are also read in addition to
> +.BR @SYSCONF_USR_DIR@/rt_tables " or " @SYSCONF_ETC_DIR@/rt_tables "."
> +
> +.BR *.conf
> +files under
> +.BR @SYSCONF_USR_DIR@/rt_protos.d " or " @SYSCONF_ETC_DIR@/rt_protos.d
> +are also read in addition to
> +.BR @SYSCONF_USR_DIR@/rt_protos " or " @SYSCONF_ETC_DIR@/rt_protos "."
> +
>  .SH SEE ALSO
>  .br
>  .BR ip (8)

This results in the same paragraph twice??

FILES
       *.conf     files      under      /usr/share/iproute2/rt_tables.d      or
       /etc/iproute2/rt_tables.d    are    also    read    in    addition    to
       /usr/share/iproute2/rt_tables or /etc/iproute2/rt_tables.

       *.conf     files      under      /usr/share/iproute2/rt_protos.d      or
       /etc/iproute2/rt_protos.d    are    also    read    in    addition    to
       /usr/share/iproute2/rt_protos or /etc/iproute2/rt_protos.




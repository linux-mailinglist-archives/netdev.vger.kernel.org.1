Return-Path: <netdev+bounces-101326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C178FE232
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1830BB277ED
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0712C15575C;
	Thu,  6 Jun 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sno4N/Wn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAC115573A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664563; cv=none; b=TP0MvQLqYP1RwDe79ENOdBLGx0FoxXebGtwtNz/JHEzKJ+eKz6Z3XtX499ZeeRuEdK56r6Kua8Gijn4NoH7gWTPCVuiCvbnll8TCuESSqDIPhNWuJwBR3DJmnAExb2MeoewM7XBX1Jsbu+qr1xkF4u77rkw2nLd7UkhOka7rMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664563; c=relaxed/simple;
	bh=mCpxfybVw+s5t6VAkDxz45g2sACkRSwSf/rV11JR9GM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QjIdi8kV8staeBWIt0CHE54CQtQS9ka2SeQoisVnARwO0fOv7JGiRxyqtSOmx7uay44w4uM/YpiBdYRFtMOiu/g3LdoqdkSj5Mgmgjoz+8eFlI6sKjmzTRGa8GJGXLssj9i8EkGsCeQMFkX3KRfrQa/grtO65JgEXnTdqNT5Gu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sno4N/Wn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a68b0fbd0so716967a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 02:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717664560; x=1718269360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jhqJzVWKZBINGIderyOHidcYli4dqLXjpNqkP4LDD4=;
        b=Sno4N/WnFaQINr8Gs0aaNwukx/lRXBuJ9NxlnuduyvFaKtcO7NfXQZCZBqsesPJtdr
         VCtWpIGqlt8S9lPOYx//psQgympqg3euGtblr5HvagY4wPZ8fUeGcvJlu2Eyj9rkcOEW
         95ly1pGMSy4rvDGsdD6mGrXRVhLEX6zJoIqoK9kLMWbx39GTKMHo9N4yJuI7+8iOtkvc
         Pk5pGgP+h05oOSxa1iOjKgSprHdtSl2VGk+e5LJ6nNRt6MT/9RhDqrnzpveeUbI2+KGY
         u3L8ln8r/dLaZHM1qDHFoWLv1O+a8vqKCkSgo4Tf0k3zUwj0pe4DMFzf0ajvq5vthhm+
         meXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664560; x=1718269360;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jhqJzVWKZBINGIderyOHidcYli4dqLXjpNqkP4LDD4=;
        b=kaHIXqLGtqyyMLqARauDUMAqOecRz9d9AEK2v919Wsqe29CB7RgG9jWMUPsqP5k44x
         5QJ3/EJYJY4uNFWFdApm6hPEKgKatyO/kv59mgtds/7NrUH1yJcRT1ShmtCIiefHdlkm
         cFPo0Rs1uJZdwn9iH0s8G6f07mq6kVuSXotc23xASCHbfjmwh6NoZDfrF8I8wXKRCA5w
         WYkYtCHH/IC5s/OVs/As5IV7/I0uARLP0rRfuKNx2qvG2cw+O3lmOu5195htWYS/jL3l
         lkDW5aVIgtPY8HpLwV7r6EIDTbhWBas8ZgmgaYnsRdROGRZ1uuLJLkrtwEQMw8KwamYk
         a1BA==
X-Forwarded-Encrypted: i=1; AJvYcCV/EXvVQcB88RnIz4pSM6Cu+Jk5NWaDqJVX2dkPK5gchKgZrXeq/j/+oRwLSvbY8lx8FG5c++QwUYB/52zFBWUjm/ExpbVc
X-Gm-Message-State: AOJu0Yxp9Yoo5Sq6iudJHmuzhVYZ/YhwP+aAXIr4xClK8nOFa4HpzVff
	+UZuXX1y88Zsn0Pzw8w6NgjWFhOWTr6oPcamS8GAEzv9Ml4Je38k2AGgXfXGsMPhgRNSacMYCo9
	n
X-Google-Smtp-Source: AGHT+IFaVLx5dgwnC0TMCfiKkqRrwIvNS5Mx2Z2QJryQfdCTPctVUM2HpPWn3S2o+xJhrcNy53Wl+g==
X-Received: by 2002:a50:aa93:0:b0:57a:27f5:1272 with SMTP id 4fb4d7f45d1cf-57a8b6b709fmr3119565a12.24.1717664560342;
        Thu, 06 Jun 2024 02:02:40 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9b9d0sm740521a12.2.2024.06.06.02.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:02:39 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:02:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Jeremy Kerr <jk@codeconstruct.com.au>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] net: core: Implement dstats-type stats collections
Message-ID: <0510655b-f42e-47e0-81e6-29ab58645c51@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-dstats-v1-2-1024396e1670@codeconstruct.com.au>

Hi Jeremy,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Kerr/net-core-vrf-Change-pcpu_dstat-fields-to-u64_stats_t/20240605-143942
base:   32f88d65f01bf6f45476d7edbe675e44fb9e1d58
patch link:    https://lore.kernel.org/r/20240605-dstats-v1-2-1024396e1670%40codeconstruct.com.au
patch subject: [PATCH 2/3] net: core: Implement dstats-type stats collections
config: x86_64-randconfig-161-20240606 (https://download.01.org/0day-ci/archive/20240606/202406061253.ZgaLHWWp-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406061253.ZgaLHWWp-lkp@intel.com/

smatch warnings:
net/core/dev.c:10871 dev_fetch_dstats() error: uninitialized symbol 'dstats'.

vim +/dstats +10871 net/core/dev.c

85bc70c64e8362d Jeremy Kerr     2024-06-05  10860  void dev_fetch_dstats(struct rtnl_link_stats64 *s,
85bc70c64e8362d Jeremy Kerr     2024-06-05  10861  		      const struct pcpu_dstats __percpu *dstats)
                                                                                                         ^^^^^^

85bc70c64e8362d Jeremy Kerr     2024-06-05  10862  {
85bc70c64e8362d Jeremy Kerr     2024-06-05  10863  	int cpu;
85bc70c64e8362d Jeremy Kerr     2024-06-05  10864  
85bc70c64e8362d Jeremy Kerr     2024-06-05  10865  	for_each_possible_cpu(cpu) {
85bc70c64e8362d Jeremy Kerr     2024-06-05  10866  		u64 rx_packets, rx_bytes, rx_drops;
85bc70c64e8362d Jeremy Kerr     2024-06-05  10867  		u64 tx_packets, tx_bytes, tx_drops;
85bc70c64e8362d Jeremy Kerr     2024-06-05  10868  		const struct pcpu_dstats *dstats;
                                                                                          ^^^^^^
Don't declare a local dstats which shadows the function scope variable.

85bc70c64e8362d Jeremy Kerr     2024-06-05  10869  		unsigned int start;
85bc70c64e8362d Jeremy Kerr     2024-06-05  10870  
85bc70c64e8362d Jeremy Kerr     2024-06-05 @10871  		dstats = per_cpu_ptr(dstats, cpu);
85bc70c64e8362d Jeremy Kerr     2024-06-05  10872  		do {
85bc70c64e8362d Jeremy Kerr     2024-06-05  10873  			start = u64_stats_fetch_begin(&dstats->syncp);
85bc70c64e8362d Jeremy Kerr     2024-06-05  10874  			rx_packets = u64_stats_read(&dstats->rx_packets);
85bc70c64e8362d Jeremy Kerr     2024-06-05  10875  			rx_bytes   = u64_stats_read(&dstats->rx_bytes);
85bc70c64e8362d Jeremy Kerr     2024-06-05  10876  			rx_drops   = u64_stats_read(&dstats->rx_drops);
85bc70c64e8362d Jeremy Kerr     2024-06-05  10877  			tx_packets = u64_stats_read(&dstats->tx_packets);
85bc70c64e8362d Jeremy Kerr     2024-06-05  10878  			tx_bytes   = u64_stats_read(&dstats->tx_bytes);
85bc70c64e8362d Jeremy Kerr     2024-06-05  10879  			tx_drops   = u64_stats_read(&dstats->tx_drops);
85bc70c64e8362d Jeremy Kerr     2024-06-05  10880  		} while (u64_stats_fetch_retry(&dstats->syncp, start));
85bc70c64e8362d Jeremy Kerr     2024-06-05  10881  
85bc70c64e8362d Jeremy Kerr     2024-06-05  10882  		s->rx_packets += rx_packets;
85bc70c64e8362d Jeremy Kerr     2024-06-05  10883  		s->rx_bytes   += rx_bytes;
85bc70c64e8362d Jeremy Kerr     2024-06-05  10884  		s->rx_dropped += rx_drops;
85bc70c64e8362d Jeremy Kerr     2024-06-05  10885  		s->tx_packets += tx_packets;
85bc70c64e8362d Jeremy Kerr     2024-06-05  10886  		s->tx_bytes   += tx_bytes;
85bc70c64e8362d Jeremy Kerr     2024-06-05  10887  		s->tx_dropped += tx_drops;
85bc70c64e8362d Jeremy Kerr     2024-06-05  10888  	}
85bc70c64e8362d Jeremy Kerr     2024-06-05  10889  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



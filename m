Return-Path: <netdev+bounces-214450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E591B29992
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E0C7A6A00
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 06:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51442741A6;
	Mon, 18 Aug 2025 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o79djgtn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E1A2727FA
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498027; cv=none; b=Yhndq2syWZgdyfFD5cV0eeKVsLregATKTxzWb9fgPgCw2NQ3tygPMiwhWj9DgQLLZsZix/bFoifJPfQtwe5lFqnpd16RFgC+MQ6YBnaHvHT4dKsH8/gl9pvhtFmQ/0NbJaiO1dsPeEpA1FbREqmuWS9XFgzBZg2mJ2IKuE4UEuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498027; c=relaxed/simple;
	bh=T3q+O+jof6fhFKBiJ6CVFzCkkLe74GTWxIh8QQz46AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RqT4SM1M60AKHibyL1fdER5kCM66Jdd8uV53jmop+uh/0lNS37efInujuQORURTPHe8RVtFDRIX6a/cxP0AuAtiBNgg58ElLUxygGIcWgUK0ZdMZxjlyoKtO16+mxcG0mNirl0rfnHJ8fW7sAApHJG3H0S3lXOYxsTa+TsaEHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o79djgtn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso2795066f8f.0
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 23:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755498024; x=1756102824; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vv+EedLDos6KkXvRZMzob7Rp+3yduDfdutqU9xZjFI0=;
        b=o79djgtn7QvSzLGuvQ1CvLorExmkzRRNtw/+8zFCgEavVWGu9cxJ256R90reNkgMgz
         6kNgpOtHoX2IR5jH/EdTGTUBuoPYC7eIRxOquUcqUUQphtyIU+W+8YUFJPqIxSOy/Prh
         5DCF8a+dl5VpHUJAZkpc12BdNDjXgcfT+vBUq5efvFMb+EcBTl5X1aLrfiu8OJp4gHfi
         bbbhbo5HF8scisKP9IQ4BwIRByr0+ZL6Na86WUs/GAjx1jAhZ1OebG1wltEK0+EwzgdJ
         XgG4Wtxn2pOh/KKEXIGNL6m/Qd/y1teahUk3OziForYcZ5cqGoj3xKcbEYU/c4JZy63+
         QG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755498024; x=1756102824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vv+EedLDos6KkXvRZMzob7Rp+3yduDfdutqU9xZjFI0=;
        b=PMbztGx8gqujoY1noPk/zjCxC5Ypjj34rY3bNmX3H0PGVitxmtkPcYrsVLPc9zrKYt
         7gWQEXw/iamh3shZrGXB8wX5sFsYKF8ZsIU6SdxJ9YSoF0+0Vt6dprzAp8lzJHRN5+0/
         p56dcpFOCqdp4M343HL5/UTig68vCwDa88mQIPJOIj1JKuKM/z9kRPnn5QB6lzzJTBep
         N1p+7N6Krj9QW4wJT6F9lGPZX1U9pgpK/iy2s1zqnfMNtM4wOvgPGOypJmByrYL2SG6E
         i2azNhR+Fbsm2thT/aXwtvZkufoqyi/XmQB9oDowX4D5ZIC4RY2zhR7gUN4p4zUND0QJ
         Rcaw==
X-Forwarded-Encrypted: i=1; AJvYcCUJHS/lMsaewbUZ/dT2gyCA9LEhuf1j0BWrnFbQphrVScScMyHr7oWjpSbOPbqxtZlQnlEUZ7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuoKcN8R2Rg100Kj23EP7Cx6LwJrbT27TZnzvWRe/CMefUs+Ve
	LGSs1UArmoz2Jgx9QzBxU0EmwxgtqpnDTrZe+jsNVBszpgkHcEb8ELgaYtpLv2q4Eqc=
X-Gm-Gg: ASbGnctO/735Q13fFA09XY5lAPzm/ZibEu/sLpjKUj1ej6N06edtEfjbpKDCgipLQJJ
	HYu2vrJqONuxrERBCPono5N3gkNiWEufxTIjtZbGL7cwJxiYsQNbjo7BV6d6aAvjpout7os/CII
	8bJJ7+peKS+62lgXCg/qTGqWpYvPC2pOJzrue1s8oW9/synz67VX5mfXYAKrcqN9xQj48k2gHKO
	+PsMi7uIAhcdIPGF7Cln1M9RfsZHDvGGFcqywAoldKvmwNnR0er4LMbpz5MBGitawG1NvpthACv
	FEmApZXV4RJzFoPT2WNAy2WV2oESglUpKkTcia+rnnrYYWCPcw7EOJh1W6W4nlI4hL3BXa5sHKG
	mf8e/CCIeLbJNkHDLV0/JeJjRRoU=
X-Google-Smtp-Source: AGHT+IG+5SFi/GAbP4l+i/xmyijRNIVvSEjZ/3P/W3aR8A+Chf11iBLXkTTgzrgOP4ZfTjF9okFrnw==
X-Received: by 2002:a05:6000:2284:b0:3b9:1635:c13 with SMTP id ffacd0b85a97d-3bc684d7af0mr5411496f8f.16.1755498024235;
        Sun, 17 Aug 2025 23:20:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb676caf79sm11538282f8f.42.2025.08.17.23.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:20:23 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:20:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Jason Xing <kerneljasonxing@gmail.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 1/2] xsk: introduce XDP_GENERIC_XMIT_BATCH
 setsockopt
Message-ID: <202508171049.SGYNFbP3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811131236.56206-2-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/xsk-introduce-XDP_GENERIC_XMIT_BATCH-setsockopt/20250811-211509
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250811131236.56206-2-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next 1/2] xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
config: s390-randconfig-r073-20250817 (https://download.01.org/0day-ci/archive/20250817/202508171049.SGYNFbP3-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508171049.SGYNFbP3-lkp@intel.com/

smatch warnings:
net/xdp/xsk.c:1495 xsk_setsockopt() warn: inconsistent returns '&xs->mutex'.

vim +1495 net/xdp/xsk.c

48248366d9de2a Jason Xing         2025-08-11  1460  	case XDP_GENERIC_XMIT_BATCH:
48248366d9de2a Jason Xing         2025-08-11  1461  	{
48248366d9de2a Jason Xing         2025-08-11  1462  		unsigned int batch, batch_alloc_len;
48248366d9de2a Jason Xing         2025-08-11  1463  		struct sk_buff **new;
48248366d9de2a Jason Xing         2025-08-11  1464  
48248366d9de2a Jason Xing         2025-08-11  1465  		if (optlen != sizeof(batch))
48248366d9de2a Jason Xing         2025-08-11  1466  			return -EINVAL;
48248366d9de2a Jason Xing         2025-08-11  1467  		if (copy_from_sockptr(&batch, optval, sizeof(batch)))
48248366d9de2a Jason Xing         2025-08-11  1468  			return -EFAULT;
48248366d9de2a Jason Xing         2025-08-11  1469  		if (batch > xs->max_tx_budget)
48248366d9de2a Jason Xing         2025-08-11  1470  			return -EACCES;
48248366d9de2a Jason Xing         2025-08-11  1471  
48248366d9de2a Jason Xing         2025-08-11  1472  		mutex_lock(&xs->mutex);
48248366d9de2a Jason Xing         2025-08-11  1473  		if (!batch) {
48248366d9de2a Jason Xing         2025-08-11  1474  			kfree(xs->skb_batch);
48248366d9de2a Jason Xing         2025-08-11  1475  			xs->generic_xmit_batch = 0;
48248366d9de2a Jason Xing         2025-08-11  1476  			goto out;
48248366d9de2a Jason Xing         2025-08-11  1477  		}
48248366d9de2a Jason Xing         2025-08-11  1478  		batch_alloc_len = sizeof(struct sk_buff *) * batch;
48248366d9de2a Jason Xing         2025-08-11  1479  		new = kmalloc(batch_alloc_len, GFP_KERNEL);
48248366d9de2a Jason Xing         2025-08-11  1480  		if (!new)
48248366d9de2a Jason Xing         2025-08-11  1481  			return -ENOMEM;

mutex_unlock(&xs->mutex); before returning

48248366d9de2a Jason Xing         2025-08-11  1482  		if (xs->skb_batch)
48248366d9de2a Jason Xing         2025-08-11  1483  			kfree(xs->skb_batch);
48248366d9de2a Jason Xing         2025-08-11  1484  
48248366d9de2a Jason Xing         2025-08-11  1485  		xs->skb_batch = new;
48248366d9de2a Jason Xing         2025-08-11  1486  		xs->generic_xmit_batch = batch;
48248366d9de2a Jason Xing         2025-08-11  1487  out:
48248366d9de2a Jason Xing         2025-08-11  1488  		mutex_unlock(&xs->mutex);
48248366d9de2a Jason Xing         2025-08-11  1489  		return 0;
48248366d9de2a Jason Xing         2025-08-11  1490  	}
c0c77d8fb787cf Björn Töpel        2018-05-02  1491  	default:
c0c77d8fb787cf Björn Töpel        2018-05-02  1492  		break;
c0c77d8fb787cf Björn Töpel        2018-05-02  1493  	}
c0c77d8fb787cf Björn Töpel        2018-05-02  1494  
c0c77d8fb787cf Björn Töpel        2018-05-02 @1495  	return -ENOPROTOOPT;
c0c77d8fb787cf Björn Töpel        2018-05-02  1496  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



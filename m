Return-Path: <netdev+bounces-206840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E98C1B047F1
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 21:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E10D7B141E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 19:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ABD20C00B;
	Mon, 14 Jul 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TrsPwXzu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1981494C3
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521868; cv=none; b=dbvJCXY+O7KhBNCgd49lW8/eKrVUssgxSmrTpv0Xo+Z024C3ceoknLRvOuiDN9bGi7qqrQM/u/ElBmg19W1FIue1sX1rniiwflG0n0P2pMkN8aIh2bjBtcvtTRLyF+voWVftirKX7qu+PJ5wFCamhCa4NKKA4o2LzVQwBjU67Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521868; c=relaxed/simple;
	bh=r3KO+ZBs4mN082/WzjFPu6+tKInahyanTvO0ZCUAo/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NYc/bt83bou2WuCV0rpWyNZTqhmHNVMKjyA97wunJU+6DSEAiNRDFAiCGCDoLI+OezN5/x+I375mdFNoT4xTyRdXyxa4wKbRNsWousnITqOA3BAbHvAFp10nUHldlh/Y+GtyC7IMHJljdcSQyhSWGvX3lfguYJrxR+/CkwT+Z44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TrsPwXzu; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73ce2761272so2641357a34.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752521866; x=1753126666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sP/J78YSZFnZNYcFRTT3/TqZZq4tSvgtl6O7DciL3GA=;
        b=TrsPwXzuu5S+SjzRHJM4Ljplet3/tn+FzAUYaPewiO4Lhw/kIQc7oKrmZvj8U1vLxE
         JBYEcXOWuGEGpNi6sI4rYyvNxUpZOiQmlq6yngUN+fAjvUzfI29ARoMvxATz5HGPuuNF
         5LbXjMGeDbRzBdCPhYKZemnedfchNYimNZcz1bwM2OOuZzwkuk1RMaN4KdYlBpEnuK46
         Ire2RQ8bVR9pwya/wv2Q7Uyhx5+x1QgG17vzl8tBab+NLFx7n5ChdJfDfU/ARCi0fRCR
         zW0utb99kCEJ6i0oOzdAzNoA/ueUNiRPQ0xJelMJe5Cdj70XA0NCNg+stuWrmCu6cFuD
         3CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752521866; x=1753126666;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sP/J78YSZFnZNYcFRTT3/TqZZq4tSvgtl6O7DciL3GA=;
        b=Q0tO/sBzWabFqp481PJhU6//gQRgamMvwn2HQLZ6SNtLeVAT8P1tvKZmaxNIBABbv1
         KkT5jHnHztfXEwZpLH6HMSL+GJioRbi2JPNUNY6qBlnhwqyDioGAdL0Nb7YgkoPP3c6I
         CFy911qIb2g/jKlLOf9xcbZZhu4YE53Vnv8G0ZZ9CC1zwLuWz5Yp6c80gX18UnFkrrGc
         kWGTEO7lgdzsLqtU2xSn/ij2uKTiHDnNQ47tI3p6ki4hunuoJsm9C8f8RHIFqk++DxLy
         yfm9ZYfAIhRihNeuB61a+4hDOMHYtwBclUWYLdCsb8pn8etpDKoA8i4uYh+5xe70olxC
         4MIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPqcRnH70aGMNp4KtIMITDtnAx7gTTekPQiMazn1Hke/aJO30qamifjcMb/gIH/F8Z3Snrmlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzp7jionXnFJF3j+/JEjtZqhj8HR4IIQklWkh+5mFor9QVo/K2
	GP5bpQ7AoP/w1zURFcMv4tyr1TjNaXO9OD144sMQFHdwx6uTADJYImFD9jglKEJq0qk=
X-Gm-Gg: ASbGncuS2f5XETEDWf4z8mck0MbQ3lH/t3JDuOvtzGjJLNckWEzZ5SgGNK+OPqaoEQT
	Vd74cxvyOrjIF5pUHL+veVWgwpEh4MOp3H2PScDwEf81QWAPzwrXjoV5eQ1QBFbJcWYRep2aTCS
	suz4W7PSC+gQnIAwa1/CgTIn4gB9D1T7jY84DuHvOA7izVPFaD7yxKgvhAPKGvtn/hZUPP9eX0T
	v0UYwnlIrIIJVH7maYblcfgw0KQJ4vzeMHJZQyBzbjFnikNyQzn8I74SsdelQf4bM7x2bDZOnoa
	obegj6ACO4DKWxDFpj47/kBUo0JX2V5mpTCjpSDA9i63aGQN0Trxf6nILzNOfJjWtd5XmXHmMyb
	3bSvNqxQyPshoA8t88VRG4y6BC2aHEw==
X-Google-Smtp-Source: AGHT+IFErlbQA7v+YncKKuLD+GZLIWHCFOI/036UbG1GrAOyALCZ86WcXDhbFE3hQMC28zdAmyVLWQ==
X-Received: by 2002:a05:6830:7105:b0:72b:8aec:fbd4 with SMTP id 46e09a7af769-73cfc2b4cacmr10268075a34.3.1752521866082;
        Mon, 14 Jul 2025 12:37:46 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12a609esm1658573a34.53.2025.07.14.12.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:37:45 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:37:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, admiyo@os.amperecomputing.com,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v22 1/2] mailbox/pcc: support mailbox management
 of the shared buffer
Message-ID: <3806fc87-e574-46cf-98af-158c37f640e0@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710191209.737167-2-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mailbox-pcc-support-mailbox-management-of-the-shared-buffer/20250711-031525
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250710191209.737167-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH net-next v22 1/2] mailbox/pcc: support mailbox management of the shared buffer
config: x86_64-randconfig-161-20250711 (https://download.01.org/0day-ci/archive/20250712/202507120609.Myazax08-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507120609.Myazax08-lkp@intel.com/

smatch warnings:
drivers/mailbox/pcc.c:498 pcc_send_data() error: uninitialized symbol 'ret'.

vim +/ret +498 drivers/mailbox/pcc.c

86c22f8c9a3b71 Ashwin Chaugule    2014-11-12  490  static int pcc_send_data(struct mbox_chan *chan, void *data)
86c22f8c9a3b71 Ashwin Chaugule    2014-11-12  491  {
c45ded7e11352d Sudeep Holla       2021-09-17  492  	int ret;
bf18123e78f4d1 Sudeep Holla       2021-09-17  493  	struct pcc_chan_info *pchan = chan->con_priv;
e332edef98ddac Adam Young         2025-07-10  494  	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_hdr;
e332edef98ddac Adam Young         2025-07-10  495  
e332edef98ddac Adam Young         2025-07-10  496  	if (pchan->chan.rx_alloc)
e332edef98ddac Adam Young         2025-07-10  497  		ret = pcc_write_to_buffer(chan, data);

Hi Adam!  :)

ret is uninitialized on the else path.

e332edef98ddac Adam Young         2025-07-10 @498  	if (ret)
e332edef98ddac Adam Young         2025-07-10  499  		return ret;
8b0f57889843af Prakash, Prashanth 2016-02-17  500  
c45ded7e11352d Sudeep Holla       2021-09-17  501  	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
c45ded7e11352d Sudeep Holla       2021-09-17  502  	if (ret)
c45ded7e11352d Sudeep Holla       2021-09-17  503  		return ret;
c45ded7e11352d Sudeep Holla       2021-09-17  504  
e332edef98ddac Adam Young         2025-07-10  505  	pcc_hdr = pchan->chan.shmem;
e332edef98ddac Adam Young         2025-07-10  506  	if (ioread32(&pcc_hdr->flags) & PCC_CMD_COMPLETION_NOTIFY)
e332edef98ddac Adam Young         2025-07-10  507  		pchan->chan.irq_ack = true;
e332edef98ddac Adam Young         2025-07-10  508  
3db174e478cb0b Huisong Li         2023-08-01  509  	ret = pcc_chan_reg_read_modify_write(&pchan->db);
e332edef98ddac Adam Young         2025-07-10  510  
3db174e478cb0b Huisong Li         2023-08-01  511  	if (!ret && pchan->plat_irq > 0)
3db174e478cb0b Huisong Li         2023-08-01  512  		pchan->chan_in_use = true;
3db174e478cb0b Huisong Li         2023-08-01  513  
3db174e478cb0b Huisong Li         2023-08-01  514  	return ret;
86c22f8c9a3b71 Ashwin Chaugule    2014-11-12  515  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



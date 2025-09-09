Return-Path: <netdev+bounces-221106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F47B4A41B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCB63BEB59
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF3522AE5D;
	Tue,  9 Sep 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJfDcmf4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B61E130F
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403986; cv=none; b=ENuOyqGG49I9HK1Or/b60oplkA16+GnPeF4hSWQGzypCI4BOtfmgwptDwGIUgIksTPV8IXJxeU/FyQ1PRfvOy/NrECTXeY9PrL4bC+t3pELP1Wso21WJ/QPMqiEeVG+pK+MQHDKaIh4PDf4yFden6swkk3B/8KQ2vGQwY1bGD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403986; c=relaxed/simple;
	bh=ZZe9wmDlwjGdZnxRKhMHlMpZi0LAkIrFZqZ+E8yxWoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oNBZVqgZKY6Yyk1XzQAoORWjbrweA4eISliThdUjcnQASWAIwBtgACnKYxMCRtgDf5dnLAd3sJm5BNTLYn5akzua4Tkg0Pj1SzvMZsXpKXOHMBIv3T672k2yS7DJVrIJNc4vkLfaOqg5mD0JNv0VH69WKcERf/l4sJKi2n1SHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJfDcmf4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso44731855e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757403982; x=1758008782; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5M32hgKB0kEBzftm4Jh2+/JRaIoNo+cUGS8t4bvwaA4=;
        b=lJfDcmf4qpoU05XdXpVOEWtYaxjOR9TNzvri5oE4H+l2wONtxX37ljo23CLUyXgSdV
         cl6Unqpc6Ok5Wiu2ZKoztCPIxXD64gYopSoWtuly0y6hzddBXWVfKd8pq4gFjYj9C2Zu
         uaXFeToDnYMoWXh7NQMsCzfo/IPp48pn1Q031CKYFDdVHYG9MrBkCIX1dpSmUWZTBEgM
         dAW/D5yMSbMlVGKKBou/tiJjIAlsri8hwYw0q87soS1oiQHF97NwOSzcyc4Wrs1HRUkS
         OrE0nnsgdK1vVZn+5UwigY4Cp46KAmCV/dKXxWMbxy+2H0/b3zMOZleP7nChLRt0C0Kp
         3sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403982; x=1758008782;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5M32hgKB0kEBzftm4Jh2+/JRaIoNo+cUGS8t4bvwaA4=;
        b=bPlWY+E2U2afipwtbsmwQK8zxBr3zDEOkmwtJybZG735AJ5fveoylrwHlR8FA5Nofo
         bNVUVPzedvMo1akocXvluNTn9o/oBn0MTopSbHL0vtaZFsa9oOzfQAP8SovD+q2M29MF
         /f/T4cwavgL5G+sNOZ/ALbqzg1vvRp4dIkyq5U7Q/SBoCkjarY8elWJFjGf9UL0aDtLl
         aQvmMkXwZYLFkaJRVxNH9ZkceauCCAd7jK/eM3hs14r6TLy8dJw/5uDGXCAHMKPlGnUJ
         cAp3daGv9m9LNYj/0EVhJZ0KywfauU9vXj54kUYdbUH9S2oCgOBV+0Pgtk3noIwQj55B
         Qh7A==
X-Forwarded-Encrypted: i=1; AJvYcCW7smgIoKOf/UUm9Ggyu/3cOag0ViEgo6/+eqw1DfBe4ZPZVQJPLvufvaWj+TCX9dSLRMScwxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/Ta7YB7UeWOkkfnc9cfeNBF3o/vWHuVwCY0AmeIyXOQJQVED
	MVeCp8YF+qGfsWMcfLXYDgo7yxJAkK9QaVdN/FMeaLt8J7L6am5tct/Uod97cUeQlvk=
X-Gm-Gg: ASbGncs9cgczgqEVH0a90KUAjfPvMrHJkjFBZYlFO/jgnqe1783CU1J5CY/utubAx69
	WbowknY8fU3t73irCidEtDp8CgmQrdlx4T9gbZ+lihHa1FRGnVqLR9M3T7rea+MsNt4QyZZeMqH
	QteMUHJX3noD5FCEbid42KaG4tLAI7DgrZrFMV05aUAdi1QuAxWfFDB4A4EWgklSlw1p59AD2hD
	aUGNfq6MmHTD3bdcUN1vMpFi3E4TgQnBw893diOw/P64Rz3UufdDtQL5zU0VgRhkbhv0KZcWErY
	UQXzK25nOE6HC/KN0CGqFIeuqucqGk8/vGJ1CS3fsPanlCLE32QfLLRNZHBFJwG8lZuIKzX0kou
	J7+hzYVVEOdeuFF+gVaxCLvrw0Fg=
X-Google-Smtp-Source: AGHT+IHlCxdGNsqJVv5ToSZPstxAhLkT3+cGh+UxpgpsImI8xRCllxeoaqhmuhYiLXuwti5OOslqHw==
X-Received: by 2002:a05:600c:1548:b0:45b:88d6:8ddb with SMTP id 5b1f17b1804b1-45dddf0234emr96618025e9.37.1757403981828;
        Tue, 09 Sep 2025 00:46:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e75223885csm1474173f8f.36.2025.09.09.00.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:46:21 -0700 (PDT)
Date: Tue, 9 Sep 2025 10:46:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Rosen Penev <rosenp@gmail.com>,
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: lan966x: enforce phy-mode presence
Message-ID: <202509090831.ygWp8XHz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904203834.3660-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-lan966x-enforce-phy-mode-presence/20250905-044000
base:   net/main
patch link:    https://lore.kernel.org/r/20250904203834.3660-1-rosenp%40gmail.com
patch subject: [PATCH net] net: lan966x: enforce phy-mode presence
config: microblaze-randconfig-r072-20250909 (https://download.01.org/0day-ci/archive/20250909/202509090831.ygWp8XHz-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202509090831.ygWp8XHz-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/microchip/lan966x/lan966x_main.c:1203 lan966x_probe() warn: missing error code 'err'

vim +/err +1203 drivers/net/ethernet/microchip/lan966x/lan966x_main.c

db8bcaad539314 Horatiu Vultur     2021-11-29  1082  static int lan966x_probe(struct platform_device *pdev)
db8bcaad539314 Horatiu Vultur     2021-11-29  1083  {
db8bcaad539314 Horatiu Vultur     2021-11-29  1084  	struct fwnode_handle *ports, *portnp;
db8bcaad539314 Horatiu Vultur     2021-11-29  1085  	struct lan966x *lan966x;
e18aba8941b40b Horatiu Vultur     2021-11-29  1086  	u8 mac_addr[ETH_ALEN];
e6fa930f73a152 Michael Walle      2022-07-04  1087  	int err;
db8bcaad539314 Horatiu Vultur     2021-11-29  1088  
db8bcaad539314 Horatiu Vultur     2021-11-29  1089  	lan966x = devm_kzalloc(&pdev->dev, sizeof(*lan966x), GFP_KERNEL);
db8bcaad539314 Horatiu Vultur     2021-11-29  1090  	if (!lan966x)
db8bcaad539314 Horatiu Vultur     2021-11-29  1091  		return -ENOMEM;
db8bcaad539314 Horatiu Vultur     2021-11-29  1092  
db8bcaad539314 Horatiu Vultur     2021-11-29  1093  	platform_set_drvdata(pdev, lan966x);
db8bcaad539314 Horatiu Vultur     2021-11-29  1094  	lan966x->dev = &pdev->dev;
db8bcaad539314 Horatiu Vultur     2021-11-29  1095  
e18aba8941b40b Horatiu Vultur     2021-11-29  1096  	if (!device_get_mac_address(&pdev->dev, mac_addr)) {
e18aba8941b40b Horatiu Vultur     2021-11-29  1097  		ether_addr_copy(lan966x->base_mac, mac_addr);
e18aba8941b40b Horatiu Vultur     2021-11-29  1098  	} else {
e18aba8941b40b Horatiu Vultur     2021-11-29  1099  		pr_info("MAC addr was not set, use random MAC\n");
e18aba8941b40b Horatiu Vultur     2021-11-29  1100  		eth_random_addr(lan966x->base_mac);
e18aba8941b40b Horatiu Vultur     2021-11-29  1101  		lan966x->base_mac[5] &= 0xf0;
e18aba8941b40b Horatiu Vultur     2021-11-29  1102  	}
e18aba8941b40b Horatiu Vultur     2021-11-29  1103  
db8bcaad539314 Horatiu Vultur     2021-11-29  1104  	err = lan966x_create_targets(pdev, lan966x);
db8bcaad539314 Horatiu Vultur     2021-11-29  1105  	if (err)
db8bcaad539314 Horatiu Vultur     2021-11-29  1106  		return dev_err_probe(&pdev->dev, err,
db8bcaad539314 Horatiu Vultur     2021-11-29  1107  				     "Failed to create targets");
db8bcaad539314 Horatiu Vultur     2021-11-29  1108  
db8bcaad539314 Horatiu Vultur     2021-11-29  1109  	err = lan966x_reset_switch(lan966x);
db8bcaad539314 Horatiu Vultur     2021-11-29  1110  	if (err)
db8bcaad539314 Horatiu Vultur     2021-11-29  1111  		return dev_err_probe(&pdev->dev, err, "Reset failed");
db8bcaad539314 Horatiu Vultur     2021-11-29  1112  
e6fa930f73a152 Michael Walle      2022-07-04  1113  	lan966x->num_phys_ports = NUM_PHYS_PORTS;
db8bcaad539314 Horatiu Vultur     2021-11-29  1114  	lan966x->ports = devm_kcalloc(&pdev->dev, lan966x->num_phys_ports,
db8bcaad539314 Horatiu Vultur     2021-11-29  1115  				      sizeof(struct lan966x_port *),
db8bcaad539314 Horatiu Vultur     2021-11-29  1116  				      GFP_KERNEL);
db8bcaad539314 Horatiu Vultur     2021-11-29  1117  	if (!lan966x->ports)
db8bcaad539314 Horatiu Vultur     2021-11-29  1118  		return -ENOMEM;
db8bcaad539314 Horatiu Vultur     2021-11-29  1119  
db8bcaad539314 Horatiu Vultur     2021-11-29  1120  	/* There QS system has 32KB of memory */
db8bcaad539314 Horatiu Vultur     2021-11-29  1121  	lan966x->shared_queue_sz = LAN966X_BUFFER_MEMORY;
db8bcaad539314 Horatiu Vultur     2021-11-29  1122  
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1123  	/* set irq */
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1124  	lan966x->xtr_irq = platform_get_irq_byname(pdev, "xtr");
86b7e033d684a9 Zhu Wang           2023-08-03  1125  	if (lan966x->xtr_irq < 0)
86b7e033d684a9 Zhu Wang           2023-08-03  1126  		return lan966x->xtr_irq;
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1127  
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1128  	err = devm_request_threaded_irq(&pdev->dev, lan966x->xtr_irq, NULL,
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1129  					lan966x_xtr_irq_handler, IRQF_ONESHOT,
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1130  					"frame extraction", lan966x);
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1131  	if (err) {
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1132  		pr_err("Unable to use xtr irq");
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1133  		return -ENODEV;
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1134  	}
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1135  
5ccd66e01cbef8 Horatiu Vultur     2021-12-18  1136  	lan966x->ana_irq = platform_get_irq_byname(pdev, "ana");
40b4ac880e21d9 Li Qiong           2022-08-12  1137  	if (lan966x->ana_irq > 0) {
5ccd66e01cbef8 Horatiu Vultur     2021-12-18  1138  		err = devm_request_threaded_irq(&pdev->dev, lan966x->ana_irq, NULL,
5ccd66e01cbef8 Horatiu Vultur     2021-12-18  1139  						lan966x_ana_irq_handler, IRQF_ONESHOT,
5ccd66e01cbef8 Horatiu Vultur     2021-12-18  1140  						"ana irq", lan966x);
5ccd66e01cbef8 Horatiu Vultur     2021-12-18  1141  		if (err)
5ccd66e01cbef8 Horatiu Vultur     2021-12-18  1142  			return dev_err_probe(&pdev->dev, err, "Unable to use ana irq");
5ccd66e01cbef8 Horatiu Vultur     2021-12-18  1143  	}
5ccd66e01cbef8 Horatiu Vultur     2021-12-18  1144  
e85a96e48e3309 Horatiu Vultur     2022-01-31  1145  	lan966x->ptp_irq = platform_get_irq_byname(pdev, "ptp");
e85a96e48e3309 Horatiu Vultur     2022-01-31  1146  	if (lan966x->ptp_irq > 0) {
e85a96e48e3309 Horatiu Vultur     2022-01-31  1147  		err = devm_request_threaded_irq(&pdev->dev, lan966x->ptp_irq, NULL,
e85a96e48e3309 Horatiu Vultur     2022-01-31  1148  						lan966x_ptp_irq_handler, IRQF_ONESHOT,
e85a96e48e3309 Horatiu Vultur     2022-01-31  1149  						"ptp irq", lan966x);
e85a96e48e3309 Horatiu Vultur     2022-01-31  1150  		if (err)
e85a96e48e3309 Horatiu Vultur     2022-01-31  1151  			return dev_err_probe(&pdev->dev, err, "Unable to use ptp irq");
e85a96e48e3309 Horatiu Vultur     2022-01-31  1152  
e85a96e48e3309 Horatiu Vultur     2022-01-31  1153  		lan966x->ptp = 1;
e85a96e48e3309 Horatiu Vultur     2022-01-31  1154  	}
e85a96e48e3309 Horatiu Vultur     2022-01-31  1155  
c8349639324a79 Horatiu Vultur     2022-04-08  1156  	lan966x->fdma_irq = platform_get_irq_byname(pdev, "fdma");
c8349639324a79 Horatiu Vultur     2022-04-08  1157  	if (lan966x->fdma_irq > 0) {
c8349639324a79 Horatiu Vultur     2022-04-08  1158  		err = devm_request_irq(&pdev->dev, lan966x->fdma_irq,
c8349639324a79 Horatiu Vultur     2022-04-08  1159  				       lan966x_fdma_irq_handler, 0,
c8349639324a79 Horatiu Vultur     2022-04-08  1160  				       "fdma irq", lan966x);
c8349639324a79 Horatiu Vultur     2022-04-08  1161  		if (err)
c8349639324a79 Horatiu Vultur     2022-04-08  1162  			return dev_err_probe(&pdev->dev, err, "Unable to use fdma irq");
c8349639324a79 Horatiu Vultur     2022-04-08  1163  
c8349639324a79 Horatiu Vultur     2022-04-08  1164  		lan966x->fdma = true;
c8349639324a79 Horatiu Vultur     2022-04-08  1165  	}
c8349639324a79 Horatiu Vultur     2022-04-08  1166  
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1167  	if (lan966x->ptp) {
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1168  		lan966x->ptp_ext_irq = platform_get_irq_byname(pdev, "ptp-ext");
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1169  		if (lan966x->ptp_ext_irq > 0) {
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1170  			err = devm_request_threaded_irq(&pdev->dev,
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1171  							lan966x->ptp_ext_irq, NULL,
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1172  							lan966x_ptp_ext_irq_handler,
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1173  							IRQF_ONESHOT,
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1174  							"ptp-ext irq", lan966x);
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1175  			if (err)
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1176  				return dev_err_probe(&pdev->dev, err,
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1177  						     "Unable to use ptp-ext irq");
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1178  		}
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1179  	}
f3d8e0a9c28ba0 Horatiu Vultur     2022-04-27  1180  
925f3deb45df73 Clément Léger      2023-01-12  1181  	ports = device_get_named_child_node(&pdev->dev, "ethernet-ports");
925f3deb45df73 Clément Léger      2023-01-12  1182  	if (!ports)
925f3deb45df73 Clément Léger      2023-01-12  1183  		return dev_err_probe(&pdev->dev, -ENODEV,
925f3deb45df73 Clément Léger      2023-01-12  1184  				     "no ethernet-ports child found\n");
925f3deb45df73 Clément Léger      2023-01-12  1185  
99975ad644c783 Herve Codina       2024-05-13  1186  	lan966x->debugfs_root = debugfs_create_dir("lan966x", NULL);
99975ad644c783 Herve Codina       2024-05-13  1187  
db8bcaad539314 Horatiu Vultur     2021-11-29  1188  	/* init switch */
db8bcaad539314 Horatiu Vultur     2021-11-29  1189  	lan966x_init(lan966x);
12c2d0a5b8e2a1 Horatiu Vultur     2021-11-29  1190  	lan966x_stats_init(lan966x);
db8bcaad539314 Horatiu Vultur     2021-11-29  1191  
db8bcaad539314 Horatiu Vultur     2021-11-29  1192  	/* go over the child nodes */
db8bcaad539314 Horatiu Vultur     2021-11-29  1193  	fwnode_for_each_available_child_node(ports, portnp) {
db8bcaad539314 Horatiu Vultur     2021-11-29  1194  		phy_interface_t phy_mode;
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1195  		struct phy *serdes;
db8bcaad539314 Horatiu Vultur     2021-11-29  1196  		u32 p;
db8bcaad539314 Horatiu Vultur     2021-11-29  1197  
db8bcaad539314 Horatiu Vultur     2021-11-29  1198  		if (fwnode_property_read_u32(portnp, "reg", &p))
db8bcaad539314 Horatiu Vultur     2021-11-29  1199  			continue;
db8bcaad539314 Horatiu Vultur     2021-11-29  1200  
db8bcaad539314 Horatiu Vultur     2021-11-29  1201  		phy_mode = fwnode_get_phy_mode(portnp);
18079c5e17e752 Rosen Penev        2025-09-04  1202  		if (phy_mode)
                                                                    ^^^^^^^^
This needs to be if (phy_mode < 0) { except phy_mode_t is unsigned
so it would be:

	err = fwnode_get_phy_mode(portnp);
	if (err < 0)
		goto cleanup_ports;
	phy_mode = err;

18079c5e17e752 Rosen Penev        2025-09-04 @1203  			goto cleanup_ports;
18079c5e17e752 Rosen Penev        2025-09-04  1204  
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1205  		err = lan966x_probe_port(lan966x, p, phy_mode, portnp);
                                                                                                     ^^^^^^^^

db8bcaad539314 Horatiu Vultur     2021-11-29  1206  		if (err)
db8bcaad539314 Horatiu Vultur     2021-11-29  1207  			goto cleanup_ports;
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1208  
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1209  		/* Read needed configuration */
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1210  		lan966x->ports[p]->config.portmode = phy_mode;
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1211  		lan966x->ports[p]->fwnode = fwnode_handle_get(portnp);
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1212  
9da87c6ef770f5 Geert Uytterhoeven 2023-01-24  1213  		serdes = devm_of_phy_optional_get(lan966x->dev,
9da87c6ef770f5 Geert Uytterhoeven 2023-01-24  1214  						  to_of_node(portnp), NULL);
b58cdd4388b1d8 Michael Walle      2022-05-26  1215  		if (IS_ERR(serdes)) {
b58cdd4388b1d8 Michael Walle      2022-05-26  1216  			err = PTR_ERR(serdes);
b58cdd4388b1d8 Michael Walle      2022-05-26  1217  			goto cleanup_ports;
b58cdd4388b1d8 Michael Walle      2022-05-26  1218  		}
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1219  		lan966x->ports[p]->serdes = serdes;
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1220  
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1221  		lan966x_port_init(lan966x->ports[p]);
6a2159be7604f5 Horatiu Vultur     2022-11-09  1222  		err = lan966x_xdp_port_init(lan966x->ports[p]);
6a2159be7604f5 Horatiu Vultur     2022-11-09  1223  		if (err)
6a2159be7604f5 Horatiu Vultur     2022-11-09  1224  			goto cleanup_ports;
db8bcaad539314 Horatiu Vultur     2021-11-29  1225  	}
db8bcaad539314 Horatiu Vultur     2021-11-29  1226  
925f3deb45df73 Clément Léger      2023-01-12  1227  	fwnode_handle_put(ports);
925f3deb45df73 Clément Léger      2023-01-12  1228  
7aacb894b1adf8 Horatiu Vultur     2022-01-04  1229  	lan966x_mdb_init(lan966x);
811ba277118290 Horatiu Vultur     2021-12-18  1230  	err = lan966x_fdb_init(lan966x);
811ba277118290 Horatiu Vultur     2021-12-18  1231  	if (err)
811ba277118290 Horatiu Vultur     2021-12-18  1232  		goto cleanup_ports;
811ba277118290 Horatiu Vultur     2021-12-18  1233  
d096459494a887 Horatiu Vultur     2022-01-31  1234  	err = lan966x_ptp_init(lan966x);
d096459494a887 Horatiu Vultur     2022-01-31  1235  	if (err)
d096459494a887 Horatiu Vultur     2022-01-31  1236  		goto cleanup_fdb;
d096459494a887 Horatiu Vultur     2022-01-31  1237  
c8349639324a79 Horatiu Vultur     2022-04-08  1238  	err = lan966x_fdma_init(lan966x);
c8349639324a79 Horatiu Vultur     2022-04-08  1239  	if (err)
c8349639324a79 Horatiu Vultur     2022-04-08  1240  		goto cleanup_ptp;
c8349639324a79 Horatiu Vultur     2022-04-08  1241  
b053122532d7aa Horatiu Vultur     2022-11-25  1242  	err = lan966x_vcap_init(lan966x);
b053122532d7aa Horatiu Vultur     2022-11-25  1243  	if (err)
b053122532d7aa Horatiu Vultur     2022-11-25  1244  		goto cleanup_fdma;
b053122532d7aa Horatiu Vultur     2022-11-25  1245  
a83e463036ef49 Horatiu Vultur     2023-05-16  1246  	lan966x_dcb_init(lan966x);
a83e463036ef49 Horatiu Vultur     2023-05-16  1247  
db8bcaad539314 Horatiu Vultur     2021-11-29  1248  	return 0;
db8bcaad539314 Horatiu Vultur     2021-11-29  1249  
b053122532d7aa Horatiu Vultur     2022-11-25  1250  cleanup_fdma:
b053122532d7aa Horatiu Vultur     2022-11-25  1251  	lan966x_fdma_deinit(lan966x);
b053122532d7aa Horatiu Vultur     2022-11-25  1252  
c8349639324a79 Horatiu Vultur     2022-04-08  1253  cleanup_ptp:
c8349639324a79 Horatiu Vultur     2022-04-08  1254  	lan966x_ptp_deinit(lan966x);
c8349639324a79 Horatiu Vultur     2022-04-08  1255  
d096459494a887 Horatiu Vultur     2022-01-31  1256  cleanup_fdb:
d096459494a887 Horatiu Vultur     2022-01-31  1257  	lan966x_fdb_deinit(lan966x);
d096459494a887 Horatiu Vultur     2022-01-31  1258  
db8bcaad539314 Horatiu Vultur     2021-11-29  1259  cleanup_ports:
925f3deb45df73 Clément Léger      2023-01-12  1260  	fwnode_handle_put(ports);
db8bcaad539314 Horatiu Vultur     2021-11-29  1261  	fwnode_handle_put(portnp);
db8bcaad539314 Horatiu Vultur     2021-11-29  1262  
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1263  	lan966x_cleanup_ports(lan966x);
d28d6d2e37d10d Horatiu Vultur     2021-11-29  1264  
12c2d0a5b8e2a1 Horatiu Vultur     2021-11-29  1265  	cancel_delayed_work_sync(&lan966x->stats_work);
12c2d0a5b8e2a1 Horatiu Vultur     2021-11-29  1266  	destroy_workqueue(lan966x->stats_queue);
12c2d0a5b8e2a1 Horatiu Vultur     2021-11-29  1267  	mutex_destroy(&lan966x->stats_lock);
12c2d0a5b8e2a1 Horatiu Vultur     2021-11-29  1268  
99975ad644c783 Herve Codina       2024-05-13  1269  	debugfs_remove_recursive(lan966x->debugfs_root);
99975ad644c783 Herve Codina       2024-05-13  1270  
db8bcaad539314 Horatiu Vultur     2021-11-29  1271  	return err;
db8bcaad539314 Horatiu Vultur     2021-11-29  1272  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



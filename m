Return-Path: <netdev+bounces-49182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529177F10E7
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5331F2379C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C8879FE;
	Mon, 20 Nov 2023 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSN0UEJ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF6585
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:55:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40a4d04af5cso12128315e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700477700; x=1701082500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S7yigsWpqo5NnEMD9rs1RxI3LcZvc/Yo1+fclqVDtR0=;
        b=YSN0UEJ90UZ6lQ8BkbRBAVugn9rUh79lyEiB3i1DGJymQ0kj4s+B3vYuId6XXXdHVm
         VPtUk0JM6arXTIbqRFPbHkwVpxr0sDB2RQ4zxZQCt4xspdZUuOclI60nQHqiWgIz1kj0
         ZZpFXFf6QiQmQufnPn8ESTN6FUnucugG3SY+1j6Y8M46QtfSKqB7Rnn3+DbLCppsVOIp
         HxOtLd81B3ZINczp7Zcm7SOOR8vIkXm199Tdg5kwRXC37akdPBg3OE4LDdUrYkWMO65A
         x6ERv4E1gzUNjfE/IUwddbahtucnf6tQ1hZe3ofmG+hKCPahOMuDtyV4wPJQZW0J1Z93
         2qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477700; x=1701082500;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7yigsWpqo5NnEMD9rs1RxI3LcZvc/Yo1+fclqVDtR0=;
        b=HZ67AuUdo+Dm9MqDSF/zI4b2PSfG8LlnQ/3i6KFKWQZ2uiHf02cMpeZ3svnSm4oSgL
         fF+aCKuRPmLrCqGOUf6DsI0JZ3qJR1lydINnhNM1W4gzXAI2OPgI152F5dNE74O5WYdt
         rWhJews/3wQBoWoxomMVqwQyZnU1otfwZqMdKIAicr0O3DsXKyYViDfrT5AdUqA78Pn/
         znGACQjFeW02BPc+ZWsAA3QBD6UK8GY60KlOMAT0LungnRmsnod5i55MzvapA8ZhZGqZ
         XOV9tycDTDm+OxcszZONL2eM1N9ZN52vy4nNxZCbkIj5cM0Igi+xdtOdn23JKZ501gXF
         sxHg==
X-Gm-Message-State: AOJu0YzZGbL3YwTfsZd94DQcuvn0PYfKDSF4qkjxgYP5xo+j8EODkgFm
	3aPxWBeeHoS6z6TkYvyeMhPsVO/jlX0j34nxCVk=
X-Google-Smtp-Source: AGHT+IETDFg3+zhHdqRS0r+kKYhNfXKDAirf7sGch5NG5N8rbdEccC65Ia69iOIzuyn3kUAe49YETw==
X-Received: by 2002:a05:600c:4e92:b0:405:4daa:6e3d with SMTP id f18-20020a05600c4e9200b004054daa6e3dmr5790050wmq.39.1700477700200;
        Mon, 20 Nov 2023 02:55:00 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id fb11-20020a05600c520b00b004076f522058sm17346948wmb.0.2023.11.20.02.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 02:54:59 -0800 (PST)
From: Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 20 Nov 2023 05:54:56 -0500
To: oe-kbuild@lists.linux.dev, Min Li <lnimi@hotmail.com>,
	richardcochran@gmail.com, lee@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 1/1] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <03e74acd-bb49-472a-b200-e84e11ae2865@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR03MB6932A4AAD4F612B45E9F6856A0AFA@MW5PR03MB6932.namprd03.prod.outlook.com>

Hi Min,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Min-Li/ptp-clockmatrix-support-32-bit-address-space/20231110-044554
base:   net-next/main
patch link:    https://lore.kernel.org/r/MW5PR03MB6932A4AAD4F612B45E9F6856A0AFA%40MW5PR03MB6932.namprd03.prod.outlook.com
patch subject: [PATCH net-next v2 1/1] ptp: clockmatrix: support 32-bit address space
config: i386-randconfig-141-20231111 (https://download.01.org/0day-ci/archive/20231111/202311110542.BjfgVNxz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231111/202311110542.BjfgVNxz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311110542.BjfgVNxz-lkp@intel.com/

New smatch warnings:
drivers/ptp/ptp_clockmatrix.c:1257 idtcm_load_firmware() warn: '(537972560)' 537972560 can't fit into 65535 'scratch'

vim +1257 drivers/ptp/ptp_clockmatrix.c

3a6ba7dc779935 Vincent Cheng 2019-10-31  1254  static int idtcm_load_firmware(struct idtcm *idtcm,
3a6ba7dc779935 Vincent Cheng 2019-10-31  1255  			       struct device *dev)
3a6ba7dc779935 Vincent Cheng 2019-10-31  1256  {
794c3dffacc166 Min Li        2021-09-13 @1257  	u16 scratch = IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH);

-#define SCRATCH_V520                      0xcf4c
+#define SCRATCH_V520                      0x2010cf4c

This doesn't fit into a u16 any more.  I'm not sure this a bug, but it's
a bit ugly.

7ea5fda2b1325e Min Li        2020-07-28  1258  	char fname[128] = FW_FILENAME;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1259  	const struct firmware *fw;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1260  	struct idtcm_fwrc *rec;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1261  	u32 regaddr;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1262  	int err;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1263  	s32 len;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1264  	u8 val;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1265  	u8 loaddr;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1266  
7ea5fda2b1325e Min Li        2020-07-28  1267  	if (firmware) /* module parameter */
7ea5fda2b1325e Min Li        2020-07-28  1268  		snprintf(fname, sizeof(fname), "%s", firmware);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1269  
930dfa56315517 Min Li        2021-09-24  1270  	dev_info(idtcm->dev, "requesting firmware '%s'", fname);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1271  
7ea5fda2b1325e Min Li        2020-07-28  1272  	err = request_firmware(&fw, fname, dev);
7ea5fda2b1325e Min Li        2020-07-28  1273  	if (err) {
930dfa56315517 Min Li        2021-09-24  1274  		dev_err(idtcm->dev,
1c49d3e947783b Vincent Cheng 2021-02-17  1275  			"Failed at line %d in %s!", __LINE__, __func__);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1276  		return err;
7ea5fda2b1325e Min Li        2020-07-28  1277  	}
3a6ba7dc779935 Vincent Cheng 2019-10-31  1278  
930dfa56315517 Min Li        2021-09-24  1279  	dev_dbg(idtcm->dev, "firmware size %zu bytes", fw->size);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1280  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1281  	rec = (struct idtcm_fwrc *) fw->data;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1282  
794c3dffacc166 Min Li        2021-09-13  1283  	if (contains_full_configuration(idtcm, fw))
3a6ba7dc779935 Vincent Cheng 2019-10-31  1284  		idtcm_state_machine_reset(idtcm);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1285  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1286  	for (len = fw->size; len > 0; len -= sizeof(*rec)) {
3a6ba7dc779935 Vincent Cheng 2019-10-31  1287  		if (rec->reserved) {
930dfa56315517 Min Li        2021-09-24  1288  			dev_err(idtcm->dev,
1c49d3e947783b Vincent Cheng 2021-02-17  1289  				"bad firmware, reserved field non-zero");
3a6ba7dc779935 Vincent Cheng 2019-10-31  1290  			err = -EINVAL;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1291  		} else {
3a6ba7dc779935 Vincent Cheng 2019-10-31  1292  			regaddr = rec->hiaddr << 8;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1293  			regaddr |= rec->loaddr;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1294  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1295  			val = rec->value;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1296  			loaddr = rec->loaddr;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1297  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1298  			rec++;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1299  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1300  			err = check_and_set_masks(idtcm, regaddr, val);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1301  		}
3a6ba7dc779935 Vincent Cheng 2019-10-31  1302  
7ea5fda2b1325e Min Li        2020-07-28  1303  		if (err != -EINVAL) {
7ea5fda2b1325e Min Li        2020-07-28  1304  			err = 0;
7ea5fda2b1325e Min Li        2020-07-28  1305  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1306  			/* Top (status registers) and bottom are read-only */
9fe9b9792d7236 Min Li        2023-11-09  1307  			if (regaddr < SCSR_ADDR(GPIO_USER_CONTROL) || regaddr >= scratch)
3a6ba7dc779935 Vincent Cheng 2019-10-31  1308  				continue;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1309  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1310  			/* Page size 128, last 4 bytes of page skipped */
77fdb168a3e2a6 Vincent Cheng 2021-02-17  1311  			if ((loaddr > 0x7b && loaddr <= 0x7f) || loaddr > 0xfb)
3a6ba7dc779935 Vincent Cheng 2019-10-31  1312  				continue;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1313  
9fe9b9792d7236 Min Li        2023-11-09  1314  			err = idtcm_write(idtcm, SCSR_BASE, regaddr, &val, sizeof(val));
3a6ba7dc779935 Vincent Cheng 2019-10-31  1315  		}
3a6ba7dc779935 Vincent Cheng 2019-10-31  1316  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1317  		if (err)
3a6ba7dc779935 Vincent Cheng 2019-10-31  1318  			goto out;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1319  	}
3a6ba7dc779935 Vincent Cheng 2019-10-31  1320  
7ea5fda2b1325e Min Li        2020-07-28  1321  	display_pll_and_masks(idtcm);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1322  
3a6ba7dc779935 Vincent Cheng 2019-10-31  1323  out:
3a6ba7dc779935 Vincent Cheng 2019-10-31  1324  	release_firmware(fw);
3a6ba7dc779935 Vincent Cheng 2019-10-31  1325  	return err;
3a6ba7dc779935 Vincent Cheng 2019-10-31  1326  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



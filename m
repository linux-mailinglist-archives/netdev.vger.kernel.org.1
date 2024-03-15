Return-Path: <netdev+bounces-80002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3385E87C6D3
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 01:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFEC1C21591
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 00:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFEF19F;
	Fri, 15 Mar 2024 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzmRNcwv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9E63A1
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710463642; cv=none; b=uceniJiJQWCgpfGjizt3u7/bHG3ffgX7C8oXirCdWy08Drk3zujqjghYYH/GjRZcC05nRGtvQtLxlq1YMbnmrx1QWwyYanKxAiAPjSEgOClyk0ZEvhxmG1/Fb3fE3zytC+qDWyZqIq577T+210W2wGXOSP720lBAPJyFGMVH244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710463642; c=relaxed/simple;
	bh=ILp4JQOIN1n2WSBbOqZ4K6x2BnhafDviRJcyOAdn/Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JHx347ugHCeArrcoIUhWhK10peK9Hqe9aZhpWfMvYqr7fobEaF+j+pqHALEKghe+goUQaYHIYr+dPQknNQTeqavVzVIkDej58tGC7UCcwQyaN7t0DbkaicoD9BgYv1JRwG+XgjU6cSAsBDabarefOJ3v3DJI0Yo5VKYBc4feXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzmRNcwv; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78863dc4247so67089585a.3
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 17:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710463639; x=1711068439; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3eu2yFnuUNP5GVqzmR9+8V3VmhfQSBb1IPlaPteMHo=;
        b=JzmRNcwvxUR5KddvRTDJvBiPqHqRmwDSMRjb/Rg4H9DT1B8IRNt1CWeT6/6xHzXNnc
         0yrAtOAAZf7xio0ihuIQsBUzldbMEOyh3u3TPNkusCse4ggezOtP6QNMDXcORPAmnZIP
         9cpy/vTicsdI4wKotx7MTQzYpwB80BnVW/23EAFTvFUG6XuKpr2AhSqvjk6DLbU5ULjB
         HyoiyiZPqSfFifSTDv3F1hDKQRSr/1wqlnPn9Fw9uo5GAsQ1v1cBXE24W8sepHLDdfg4
         MJUOJuGuZSbMMq9oPYt7l0B6WPKD1wibes2VWoBgz3MboMBJJBKYxLhj1V5fSbygDu7d
         mUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710463639; x=1711068439;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3eu2yFnuUNP5GVqzmR9+8V3VmhfQSBb1IPlaPteMHo=;
        b=DEl8ES3HQzSKUnIx0bhyJhZjCaV3KLDGPsooCjWPGcnlE7pMerbBVrx8g6v/AkLGVA
         iFa/CbpMpsdnmU/WLwxixmau/NhYl5zevrOwoUFCnvpjLmZ8xFSX6/6YRBEpJxG1UpWY
         tU0O9e9yp+shqlXYfr5PTcVLoDQwcgW+WhsSrJ6OmV2FBbJkRl3fR16lpfPkd0w0yAbf
         TN+i2ZXAObKrnRGp5v13SXb6qkPLtcD6VARUF/ut06x64c64uQp3R/cKNzW/Sz0yszEd
         3lJE98bwl++vFyQdg0zpRyuu5DmrjMsRO+PL5DSw3qEnGjWzB4aEPSzHRFfgsUYm/h8W
         RENA==
X-Gm-Message-State: AOJu0YxSGjnoitgQFM9lITQJvq+7heilzj7fIUZ7dZ1vphrbrc3xertB
	L4yft40hwx6PMfW5w/H1kCD0yM4DwED1GZjCcj/gwLyxPJr0hAw=
X-Google-Smtp-Source: AGHT+IH1fX9q8ZD2FtqON55jObL9p/wojsZQD/91ADiZFofQH3vc2GakB6ldFr8/E/RjXChcTQmg5w==
X-Received: by 2002:a0c:ab0f:0:b0:690:96d0:a2ce with SMTP id h15-20020a0cab0f000000b0069096d0a2cemr2967912qvb.65.1710463639496;
        Thu, 14 Mar 2024 17:47:19 -0700 (PDT)
Received: from cy-server ([2620:0:e00:550a:9f1b:4292:76f0:cb8c])
        by smtp.gmail.com with ESMTPSA id cz8-20020a056214088800b00691663dbd4csm785718qvb.78.2024.03.14.17.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 17:47:18 -0700 (PDT)
Date: Thu, 14 Mar 2024 19:47:18 -0500
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, anjali.k.kulkarni@oracle.com,
	pctammela@mojatatu.com, andriy.shevchenko@linux.intel.com,
	dhowells@redhat.com, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, zzjas98@gmail.com
Subject: [net/netlink] Question about potential memleak in
 netlink_proto_init()
Message-ID: <ZfOalln/myRNOkH6@cy-server>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Netlink Developers,

We are curious whether the function `netlink_proto_init()` might have a memory leak.

The function is https://elixir.bootlin.com/linux/v6.8/source/net/netlink/af_netlink.c#L2908
and the relevant code is
```
static int __init netlink_proto_init(void)
{
	int i;
  ...

	for (i = 0; i < MAX_LINKS; i++) {
		if (rhashtable_init(&nl_table[i].hash,
				    &netlink_rhashtable_params) < 0) {
			while (--i > 0)
				rhashtable_destroy(&nl_table[i].hash);
			kfree(nl_table);
			goto panic;
		}
	}
  ...
}
```

In the for loop, when `rhashtable_init()` fails, the function will free the allocated memory for `nl_table[i].hash` by checking `while (--i > 0)`. However, the first element (`i=1`) of `nl_table` is not freed since `i` is decremented before the check.

Based on our understanding, a possible fix would be
```
-      while (--i > 0)
+      while (--i >= 0)
```

Please kindly correct us if we missed any key information. Looking forward to your response!

Best,
Chenyuan


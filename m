Return-Path: <netdev+bounces-206913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229EB04CAB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F878189E4EB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F402E36EC;
	Tue, 15 Jul 2025 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="sqkpXhYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DFF10E3
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752538193; cv=none; b=KvmDc/aoWgr13RZwcG/I/GtIYuLORT5vuFSui6qQC9e1+I/Es6flfX4+M/okJj6/0WCNbwVLBum1dBylFSgql1NBD8EqaJZSb7nw0j2NXa6h5ek4s9rVJWeiTZMuh1Xj2jtpGtsPcNKmxQP38zr2zBn3kuTJFo+O1MXYQZ1P3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752538193; c=relaxed/simple;
	bh=E6V0VxZ4OvwaZ7TFsNZajx5CMWMrI7EKWUrbFlf8hDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zd7KvJ8dXIX4eoP7sCjYzGS4Thrl1SKLMeu6cD1un8nWEUAf6siu798ttKgYUMhVPSVqmEOJDg5nJZPb7xKo2+X3IUxchC6YwVZW3N4rxCmyz8c0SLBlFXh8gNS5bBmxrWDLRCukWVqvOx602nQS9gKb5tFDkN8e4qbl5WPNZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=sqkpXhYO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b56b1d301so2886428b3a.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 17:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752538191; x=1753142991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMhy77kbdREZspqwAq9UizJYLInT7vY/Ak5Tk7wBzns=;
        b=sqkpXhYO4oiaccI934l2LLr3bltzhj/mXDf3b4cpk0Z/BW7xGLyyLUL5IJ9bJ9iajs
         2XXU3OrnKRjQxUMr9/9dGf4Ci/6OkTC35Z/PpqsbkJpNADDRbRVYh/KEqTJksapDmpTS
         ggW5yyeRgxHv7Uqjyx3lvY9ZHRXviFsoNVOPa9H0BQCsguv/2CNlF77E634nzq9RuOBO
         sO7LGT6DlmfzgcRACv9rn9qa+nZvbirddnf1j9c1VHW2lsKxBh320OJKtshkmjKZcs8Y
         MDNzvptmWxf7kt7EtN0Bl+1UrAsifEpa47rizoOxb0LDpb+Zgb9CJZ1gwj7C9lLht9yX
         ihug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752538191; x=1753142991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMhy77kbdREZspqwAq9UizJYLInT7vY/Ak5Tk7wBzns=;
        b=FRxGWKhW+beuqu+jgADeobXLt3IGo/oxWPXcwurg/0Y+n9tbDCTbTjjA2JteNFruVN
         cNTx3WWflQqwMbY/PPQ45sIhEWX5ykW8gsYNgQBQsIb6x9UdAFsQC/78lSO27FNQ5AuW
         QNE3dOL3izOD3eupZFt/MnCoFyrg1oW/Tv621DlpbS7ydZUWFKxRqg8hRV9Janu3G/fD
         cZ9PvkNufW778IQxhlWtCQGLStbh0U8uSJseRZr1BQDPnT0+B5f/oIvUSY+0MWCUNKPf
         S30ZHzDvbmwQzGxuEHxaVvMfEFAKHK383nJigCzXv47Ik4gQZTlRURFnlqMgkRxkm50K
         JMRw==
X-Forwarded-Encrypted: i=1; AJvYcCVkBP2r5sHUDTIMOl2vWFpjwcAiFN/lhIS6wfv8oufvkxgfnw/SjvtgAtJOCeF9CMKwxOHr/b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD9CVXx1nDifd9JGqF1aixM+NSvWYrAq7q7kB3E6Q7Fb0OYY85
	JfUrqnMteUGjNHYays+BjZIVumNSRdfFGBibNWoZMfWodwOQzvBjehFcDrT2cx3b4A==
X-Gm-Gg: ASbGncuRZkgKz/bWHYs1WhUtpFD2PnoxPIpQfdxFz+tYHJxTSLe1eMRfJnl/0WOr857
	6w0/DgCxVHvySO3+XQl0xeab4O+OwJ335nHszzXBUHAf5wSmrgurjH57Q8iPyZTOWgQyrG4wMBL
	EDCyp3t9XxYxmM6P2HhD614X3smjHtfcOu1TaL3/3z2sFMqhkmANw0VImvQvGYXAGbPUqTQUDU4
	N0s0Q5UzpoRdigT7VK7wPX0aYzgvEfmPoGhyPxOxGhxbPS5ODmBepYlxu212XU7DzfQl0k3TuSl
	6y++HdkkKu1T6g9dtq1uMWtcqrzU+YTDB+96MlN5CcNZQQoH7s5lq/DrO7c4R49sUgBLFJLMDkj
	ah4JO8qOzj92UrZmTnq/sDLEbRpsk495n
X-Google-Smtp-Source: AGHT+IErhMT4Xm6TvUbvOwRPa/mRv4BME+TKicesekxjrb6mbM9nNDtsix2uqZDvP8rqSWTj9Lr5Uw==
X-Received: by 2002:a05:6300:6c04:b0:232:87d1:fac8 with SMTP id adf61e73a8af0-23287d1fd6amr13059020637.40.1752538191101;
        Mon, 14 Jul 2025 17:09:51 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe729b5dsm11057057a12.75.2025.07.14.17.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 17:09:50 -0700 (PDT)
Date: Mon, 14 Jul 2025 17:09:42 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
	security@kernel.org
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHWcRp7mB-AXcFKd@xps>
References: <20250710100942.1274194-1-xmei5@asu.edu>
 <aHAwoPHQQJvxSiNB@pop-os.localdomain>
 <aHBA6kAmizjIL1B5@xps>
 <aHQltvH5c6+z7DpF@pop-os.localdomain>
 <aHRJiGLQkLKfaEc8@xps>
 <20250714153223.5137cafe@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714153223.5137cafe@kernel.org>

On Mon, Jul 14, 2025 at 03:32:23PM -0700, Jakub Kicinski wrote:
> On Sun, 13 Jul 2025 17:04:24 -0700 Xiang Mei wrote:
> > Please let me know if I made any mistake while testing:
> > 1) Apply the patch to an lts version ( I used 6.6.97)
> 
> Please test net/main, rather than LTS:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/

Thanks for the information. I re-tested on the latest version of net/main,
which contained my patch, but it doesn't crash on 5e6d. I re-verified 
this patch and can't connect it with a null-deref in dequeue.


Here is more information no how I tested:

1) I ran `python3 ./tdc.py -f ./tc-tests/infra/qdiscs.json -e 5e6d` 100
times
2) The KASAN is enabled, and my patch is on it
3) All 100 results show `ok 1 5e6d - Test QFQ's enqueue reentrant behaviour
with netem` without any crashing in dmesg

I may need more information to trace this crash.


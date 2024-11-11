Return-Path: <netdev+bounces-143835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295B89C4640
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 20:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F4CB25A8A
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0326D1AB6CD;
	Mon, 11 Nov 2024 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHCnwxsk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228E132103;
	Mon, 11 Nov 2024 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355102; cv=none; b=ktBQ0l2GAelsRQsB4f97KMIglaYgle6vnp7VVTySUlaQy2NF1gU79eDs2F6/OycSYaK3eMn0aSFWmol3qOD8BPnfPy6T47YNm/TnwvkFof6NX5FWYZPZaK0DZedsrB/kH2EToOuo5GjlEVqZoMwLX+5Rh0gcb29toYN3IbqbJro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355102; c=relaxed/simple;
	bh=UnxF2PSlVkpkrxHQi7XWc/Kwtl1PYZ0jR3PHQHPeL+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7hwMBexCRxxYM95sG36l0vu3BA3NSDjNAIbG4cxhvVxI0zIDTqhJIUvAn/YHwCv43TdJL42Qv3WrRrVRcifZYypxKaWD/LijpxAupWlob3emKt8/KCCF2u+38BQWL/FeIwAl+gY5CY3G0DDHw2T2tEkAQE+sczc1wVqHPTQDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHCnwxsk; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ee645cf763so1071705eaf.2;
        Mon, 11 Nov 2024 11:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731355100; x=1731959900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YKSL/TMJVpaWY+Hd4NnFTo7DJqoITBThH4/8LL1WEYA=;
        b=bHCnwxskcwHHl6P3RmLkjrkLYVlE3PRncvRjr5KxJ1FFj4NXQ/I10uuYCzx2aV6+6u
         bmKPgXvr7xBhMU9QffJX8x9fIbBy1jy6QJeVNBgYw1iZuZ8OiC+YNV0LyBM8kBpb8JSe
         zSabdvV19yoRhQ7cMnpP0vfU/RFbJbBn19tDviO5nOVtolnBV27AttuWvv8HtEawFpMY
         R0ALibAG2V3wbETr6AbdBUeD+2iOyiU52Ai6GSJQtjAnHhrD7ZBVGK7LBeztZDsTFlvN
         t19M6RCvhSKVMy0PNhDcIHJjXyzJBLb/c8hAis0pxlhEQpPdnsS95iNjKEL1nHmV/WsD
         nYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731355100; x=1731959900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKSL/TMJVpaWY+Hd4NnFTo7DJqoITBThH4/8LL1WEYA=;
        b=QAD16/wdiwGxhdgaw0UL5KbRrOU38F1+vMQDebEMRnbt6d+YPAYZ9CxR6rnucVxxZC
         7lNXnzm1YU7lsizBAvIMi+uq1re5yCoo/j9hnJnlP9MjvSn4dgYgKpIH58WIWl+B6AmU
         bMZBg2Bc/c3fgG12b+ilEJh94RPmz1xQ+sC2MFFG+IZHXGm44fO+RgR+oZb1INfQNSDW
         UQ+qrJoeEXOfs2SXZg7FMnpbrWMffcf/wSM4axWW/2aoyVsZU5edCs+zOnArepwN33YS
         7kJPNTRTQ5akdAOifZnCa9m0v/hDn/yIAR3H4D2tKhxAjUs0IpqaYCRw+Spn3uZlbPke
         WrHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu35kjiaX5XvjsUhNR6Txhd61IMT8p2f+s2Fce7qep+H+trq2rbiU/HbX6ij+//wBFaP26IsLVosZDvL/e@vger.kernel.org, AJvYcCWJpoSL4Alx91Fyasfq2XQXYD5+Lsaee0KJXizhdXRHx1gzXSOSj7d/JLvHCSsRqTZW0AelNFeUup4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsaUWGkgl4UrrRnju4hig8swPpQdk0aK0xOjMnSptBRiSkyrFQ
	uunjmF5F2NiyBx9+8bT6zhEOBsCMXRy3mo6ActDiOIhPCq9IO9r2fpOkzp+nbR5anJX8FpdiesE
	6TnOjIbacCQSrRx4IELHh7b/Y3cI=
X-Google-Smtp-Source: AGHT+IGuRTC7+MFw5N38/lXlK5RNW2/IExV8eeKWBocnG3jTZn3mTyMEEPknJM79jaEbLPMZqqJtQM/0YPSoxnleeRc=
X-Received: by 2002:a05:6820:4c89:b0:5e5:7086:ebed with SMTP id
 006d021491bc7-5ee57d07b4fmr9549425eaf.7.1731355100355; Mon, 11 Nov 2024
 11:58:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109025905.1531196-1-sanman.p211993@gmail.com> <20241108195736.7b189843@kernel.org>
In-Reply-To: <20241108195736.7b189843@kernel.org>
From: Sanman Pradhan <sanman.p211993@gmail.com>
Date: Mon, 11 Nov 2024 11:57:43 -0800
Message-ID: <CAG4C-O=T_1YE6xx74RJgqAJ9X-eOCDP2SvHRXPbWKj0K6bDuaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4] eth: fbnic: Add PCIe hardware statistics
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kernel-team@meta.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	corbet@lwn.net, mohsin.bashr@gmail.com, sanmanpradhan@meta.com, 
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev, jdamato@fastly.com, 
	sdf@fomichev.me, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 19:57, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri,  8 Nov 2024 18:59:05 -0800 Sanman Pradhan wrote:
> > v4:
> >       - Fix indentations
> >       - Adding missing updates for previous versions
>
> Please don't post multiple versions a day, per:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
>
> >  .../device_drivers/ethernet/meta/fbnic.rst    |  26 ++++
> >  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  37 ++++++
> >  .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  54 +++++++++
> >  .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
> >  .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  12 ++
> >  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
> >  6 files changed, 246 insertions(+)
> >  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
>
> I just realized that you couldn't have tested this patch properly
> because you added a file, did not include it in the Makefile, and
> yet the build doesn't break. So you must be calling neither
> fbnic_dbg_init() nor fbnic_dbg_exit().
>
> Not great.
> --
Thank you for the review.
Sorry for posting multiple patches under 24 hours and for the
oversight on fbnic_dbg_init() nor fbnic_dbg_exit().
Have submitted v5 with the expected changes and test logs
> pw-bot: cr


Return-Path: <netdev+bounces-127534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC485975B03
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FD7286C49
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD81B5806;
	Wed, 11 Sep 2024 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWiWjeLj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7CE29CF6;
	Wed, 11 Sep 2024 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084090; cv=none; b=LrWRtgc2QfhFcot6Qrc9CcQ4k1eTUzc+IXXHr+BSusSrDupsWLQtuep3W6GHl1+TuSw7KU5RAqRfPIwp4aXzFgPlxF/1/cOKfKb/XbPld5ZL3m0UxF220/CG1Xju0BTx0Ct7CtdxAl57WfuozyIO2OKVMvz8UB94tb5TBk+a4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084090; c=relaxed/simple;
	bh=5vAv0xHEHWUR4r3fTqWyvOK8rQF4Idf6J6BQEQT5rz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1O9lRq/Xk0DfzTluY5I9akH+bCf9FD/TGy54tjXeMlLkPqxHC9ZQg0hXIgkMHDFllHooycbHj0MeRU1IHoE0X69Xc+ahQKUWXIdW3lOIbUHOJnM6EE3CxPDQ5tE7flQHAIEa6Pq+EQ9a1qSSRdmsEdvkIUQDCv/K6dWI1zh2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWiWjeLj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-206b9455460so1488245ad.0;
        Wed, 11 Sep 2024 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726084088; x=1726688888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KuHreHPZ1fumPZa+FCsTxllIbSqfGEHYI/hBKA5GtA=;
        b=QWiWjeLj2Z5Py2Jak8Kkq01UCwmp2Xg/H5Y9sJ47nL6ynYSWXF7/Zgjo5xQtX8+Rsq
         DvMCSjbI0BwZqPGsG6lC7bBQdV4NI3PL395DHmMTyQ+fVAPqS5ddcQRmfyzpl/+R6DvE
         61cUd1WAbacq8/6wLlc8C7ehQMdFeFnYazXKWe4s4DROWsoK1CuZVUCqaUgv4l96bqN4
         xr3YCTbiRysYf/zBCW0jahGeWUhV/ejqQEmotXG+yX7PS7ZeNYbJV5ZR1DzYcEebc4zt
         bkBLDtl/QXLHUwq1j5qtXingKkL2vI1r3sy2pajSZ4/89yF/FFC4T4yEl4rg7ir73lRp
         fYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726084088; x=1726688888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KuHreHPZ1fumPZa+FCsTxllIbSqfGEHYI/hBKA5GtA=;
        b=A/ksKFm1uXeY0UiZQ7PYyD2n8mGT1+GOgrdcoDxSEF8IWjuLhZpYd0jTjeNnrdxa+S
         0TInkbEiX2Y9FJyGG87MjnillTSWJvgMbGi6o7Ju8QiT4By31ZgMV24QuX2ijYLhCfbs
         Csu9hdEy9TbOvov8+3Int1JEsg9ru2hkHMqAWEuc+Cgbdt6/7VUbxxnGmgsA3RC7P1aO
         GnZ20ZTrxcdkJaRLZSEVDV2wDK0gWGnkuaNxqdFJF3OqXvXWdLURvc6H7iL+nnol4eEf
         BDLIlJ5mQWHjpqy68n/ApDNIiDGYxTLjZVnSr1XBtTq73rdDbXKSKpCDyUOUFzklP5bG
         yqYg==
X-Forwarded-Encrypted: i=1; AJvYcCU3iDQ/UosmP8wPXFYcl6q45lxOVi41Jfhx6dA+rWQzXJW2hjiVSh7Yn8V4/h8GV19xHKNZUtZt5i5LUO8=@vger.kernel.org, AJvYcCWMCLjYw75tj15xdRq4m2isxekXdMEF2utiqYQ8HetgHUOW6QchX5tVQjvLVeik8q8Bay2fQQLZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNPJBBcw9A5vIVdyrwvHTIr6EwvabBKFPvoTumaIkn3WTESF4
	clxvwDWuS2U4lzPhILlvKuRsDgZE9319X0TCalDPkf9xZWME74nJ
X-Google-Smtp-Source: AGHT+IFMseVfAjHOw49BEpu2f0U93aw5F8gDZTuTzAN487S358BnfYXHLQzMhK3pN75H57jLlbR4Sg==
X-Received: by 2002:a17:902:d50b:b0:205:5d71:561e with SMTP id d9443c01a7336-2076e61e061mr5082185ad.26.1726084087807;
        Wed, 11 Sep 2024 12:48:07 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:6166:a54d:77fb:b10d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe99f5sm3043945ad.213.2024.09.11.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 12:48:07 -0700 (PDT)
Date: Wed, 11 Sep 2024 12:48:06 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Qianqiang Liu <qianqiang.liu@163.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
Message-ID: <ZuHz9lSFY4dWD/4W@pop-os.localdomain>
References: <20240911050435.53156-1-qianqiang.liu@163.com>
 <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
 <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
 <ZuHMHFovurDNkAIB@pop-os.localdomain>
 <CANn89iJkfT8=rt23LSp_WkoOibdAKf4pA0uybaWMbb0DJGRY5Q@mail.gmail.com>
 <ZuHU0mVCQJeFaQyF@pop-os.localdomain>
 <ZuHmPBpPV7BxKrxB@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuHmPBpPV7BxKrxB@mini-arch>

On Wed, Sep 11, 2024 at 11:49:32AM -0700, Stanislav Fomichev wrote:
> Can you explain what is not correct?
> 
> Calling BPF_CGROUP_RUN_PROG_GETSOCKOPT with max_optlen=0 should not be
> a problem I think? (the buffer simply won't be accessible to the bpf prog)

Sure. Sorry for not providing all the details.

If I understand the behavior of copy_from_user() correctly, it may
return partially copied data in case of error, which then leads to a
partially-copied 'max_optlen'.

So, do you expect a partially-copied max_optlen to be passed to the
eBPF program meanwhile the user still expects a complete one (since no
-EFAULT)?

Thanks.


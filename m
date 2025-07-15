Return-Path: <netdev+bounces-207244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A04B065CE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5861AA80F2
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C973C29A9EE;
	Tue, 15 Jul 2025 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9JI1j1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5335529A9E4
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603207; cv=none; b=UhrU9B16diMca+qvq9fd4n/XSESIh9p1tW4qbvQcKdXqPjazphUPsfavARKIqlXKD6YO+i0qb5ZQBFOcZPXmIR5GeR8tKLMLtvCkcKPZjZiBibVacjbL/ATJQYf4HzcwjJqs7K8jpXHrFAZargRHZsBtX1R7IlM/xWeLPdSBmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603207; c=relaxed/simple;
	bh=p707MAcw9CgGwDsWDEOMwpTLYV3uZn9gyOXcVIXgbrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WElq9lXOE6xSW+5GFQSHg5XW/lWvM29y5b9Bg6UxNUbtpbVpnM7XwpcYDpxYR1Vp9KVhUHfyOb3hcrtg5O1TrUbDTfCm6r6uAVg4wHfnreVp8flHfbWhM+T+vOD5UtotKNJPPYGfm/42WT5RhkVo8QsJIfbMuDC7A2htx//LilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9JI1j1Y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2349f096605so73730445ad.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752603205; x=1753208005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWRPlWJsAVTpNbbUc7TiQbNI9HLk92v+Jn2hG7aZ0JY=;
        b=k9JI1j1YxNLSkdQ4ISkeE3/thdmSiWWysYglvLmO7/X5Se+oMIAVdwPFDIxDqHTF1K
         O47YPjyKTFXd3WqFaO8bdOGodfOo2vNdXqIsY54TyklM0v0WrtUe5dGCJucoNkm/ghLo
         RuUaSxWl06t6akELr3l1SzY1PtFZcH4YzNLW+x5RBK8wrOBfaFBDG42IArv8hBDytIgF
         IKxFw1jK7r7dsHY9neHA3vc4N6PcLRW7VNJOzmNJmEsCnPq1+hu4EPAnmfG1EyxVSCI2
         tea2Ycuc3DATO77HeLQPEPF57pOzuHQWahfb0z+ua9yfD/iV4EnwGXDhhO5Q9znHsM3R
         ASEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752603205; x=1753208005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWRPlWJsAVTpNbbUc7TiQbNI9HLk92v+Jn2hG7aZ0JY=;
        b=FmOAUoOyjE3zo0XZP6FKlA6reU8Vu68gRRcDAG3S+r/NCKwBC9Y9jw3IrMEh1Jxkbg
         8eNBB7Wmp0fY/5M+WGWq853YkAeDGffyYrwhUtDKYUluXUBofnqsHzw8kyvJmw+7oxfQ
         ybeUeD7LinhAQJnf/znYq5sTjMUTWxyJB/fTxp3EZLQJT2oPScjFl3/L23SwGyyg+Sgg
         15cy0Hn/pcOGHsre7hTqq3XDZ31kHFZ0er7SkyowNBUgnOHT53wh+eI/BJcdfSle1Kin
         +Q4lbXYwtsprSV2EEifa7gFLN5aSRzoKiQTltl1At356KH78OuQMoa46R/hUHSedog9p
         aQFw==
X-Forwarded-Encrypted: i=1; AJvYcCWy7wwG8Jqh6JQFS2r5Qk88fyjW7ZRFVTbC0Htmb/Zbq6JXyc/rQBVFDWcySteYbKkmVOSq7JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJwHgnEH0KzVyDk+rhzxBIRNhuBM+wCDelqL328ijotzJL8jN
	Mhb3SXI6QsiIsyh2T94P48mUqti8mBgvd5cKOYo+H31NigT9mBUkhuBS
X-Gm-Gg: ASbGnctjYaxYTQhR1rFwVlJZ4wAeP3O7XfOB69qJDWzWge4Wxl70jQ0g9EeH/RkVU+J
	eTCb7/ZFG5CXycXbr9KPne1LNhpPmtv7V7YyxrfYM0c8kdWxaw1OSdrqxLPhZVW7Tem8wHBWZKO
	c+Sl9ra8qizX/S26+CjKbBz70dpWjTc4vmjhHqTjAD/y0eL5lV/6ba508BSAaSMToc5LYDO6ATd
	L9lj6AnL8Lc/GKKQRvgBLxND6ejvZnIKgcIEzQ8VFyChZ9qb790lpMswAiN21tC/3OTEUxf9GJi
	dg3SmRV4Cu3hwatULXxde89qouE6l7ogLGqAAOXjFPFnfhnqsjLBwazCLYNwKgAxdDYX4Z1otdj
	efi1WnJFq+WX+BoNqUrGAVOAHUl567M4tAbDN
X-Google-Smtp-Source: AGHT+IEpOTExL5O+lo9Qr6i5nSApAIo+HRXbipgqZzDnzBFExVLgT2I9OxXWr4jyFgJ6ig29xrJYvw==
X-Received: by 2002:a17:903:234e:b0:235:129a:175f with SMTP id d9443c01a7336-23dee23805dmr267845675ad.34.1752603205316;
        Tue, 15 Jul 2025 11:13:25 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ab6efsm117405805ad.53.2025.07.15.11.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:13:24 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:13:23 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
	security@kernel.org
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHaaQ1aSVt6vSQlT@pop-os.localdomain>
References: <20250710100942.1274194-1-xmei5@asu.edu>
 <aHAwoPHQQJvxSiNB@pop-os.localdomain>
 <aHBA6kAmizjIL1B5@xps>
 <aHQltvH5c6+z7DpF@pop-os.localdomain>
 <aHRJiGLQkLKfaEc8@xps>
 <20250714153223.5137cafe@kernel.org>
 <aHWcRp7mB-AXcFKd@xps>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHWcRp7mB-AXcFKd@xps>

On Mon, Jul 14, 2025 at 05:09:42PM -0700, Xiang Mei wrote:
> 
> Here is more information no how I tested:
> 
> 1) I ran `python3 ./tdc.py -f ./tc-tests/infra/qdiscs.json -e 5e6d` 100
> times
> 2) The KASAN is enabled, and my patch is on it
> 3) All 100 results show `ok 1 5e6d - Test QFQ's enqueue reentrant behaviour
> with netem` without any crashing in dmesg
> 
> I may need more information to trace this crash.

Now I figured out why... It is all because of I used a wrong vmlinux to
test this. Although I switched to vanilla -net branch, I forgot to
rebuild the vmlinux which was still the one with my netem patches. And I
just saw "netem duplicate 100%" in test case 5e6d, now it explains
everything.

Appologize for my stupid mistake here. I think it is clearly caused by
my netem duplication patch (although the fix is not necessarily there).

I will take care of this in my netem patchset.

Sorry for the noise.


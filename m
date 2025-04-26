Return-Path: <netdev+bounces-186250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18973A9DB98
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 16:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B42B169C60
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136322FE08;
	Sat, 26 Apr 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScWREbdp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316B17BA3
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745679357; cv=none; b=W0CLlFDEFEQKSKkkPba90UL7p/j4c1shFHbMA4cPJ72YlTZ9Dj0HwLXjUXI1AIk4S8vXEMwUUcXpyPZCWfJeqzkNs/ZAbQFPiqh9yE3WAtG0CXLvgJo5dG+YH3y0YgQtvqCZqZjtKU8K5HKl1s6iRUMy23IEmTSLghP1DCZdD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745679357; c=relaxed/simple;
	bh=l4mzeRfiP6cOTO8MD508kntSdMpRed4FBzEfS0y2Bl0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ihFDUTDNxl0+5L1B9tQIzgAUWjbyG+x/YdkKoz4nXMwHleC+hI26sbLqA53+YWV2eLl3lCiyn5cqJxcvSbKSYUcbkIH1ZAnqHhlw/ZZyUhBWJ+S7MKC71rDGgn+DZprs2VdGtpG54Iv1wtJRP91zuf2hwN9cHn4kZey7EdS+KAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScWREbdp; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c560c55bc1so405358185a.1
        for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745679353; x=1746284153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsnFymaoLKnZMAYwNG5A0g1kJ/WbaFn7e//oy5xaBoo=;
        b=ScWREbdpM6/xKlA/GQLzAI2sMNyAEAWenhhjPqOqUYa2nfhgjkrPRbZAu3ALHRIyB1
         gEuIwuXlTeeFD1vAoo99zt/B4ZvphytzG5QdGOTyvweZh2v9P9v0shnpefRBattFnvjN
         sGmsowU5MErh+h8726Z/SAph7iSmQb3nVhyKvs8Y94kdAg1DrOOcwW3awVOGJqkQewlO
         CTru/G4lK3jQ7DxwoY6+yR4Un/bRj7GCWLMdAGetjMAGkT7DUrZxK9MSJsxH8lloFHmb
         WijkM6D5GIjcDp1DFWG9LEtvAHrm/mLhqTY10pBuhFQHPgQi1PrSDiWgxy1QY+joL2HY
         GkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745679354; x=1746284154;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jsnFymaoLKnZMAYwNG5A0g1kJ/WbaFn7e//oy5xaBoo=;
        b=tzuJCMntDAn3ek9os3yyOAVWhZ2aaGAhKklqL3oX9T4FQKAWSfdZ+GVeY6kjyCNw4+
         rmeEifzpOmWReqeR8ZCsgviiID6FMc6wJZJpOBaOyOqtoQ7GKF2jxc5lP8YaUNVtvlgZ
         RUTIMrF7C3sMZ4hhZXpUiWolKeAImTKv6rvAilKS7ldSNN23POlkZQyzVwnoBnZd7rh+
         HinwxKIswz2w3jHxmXLiBQbaTcpVbnS1ZVoXEZVS++/mGtcDDTMlK6RBUPNzDttSA5eF
         QFklTTEb6j32Bg8C1/nyhQmv3LFLeMA9eeOuAF1zew2VUOKAsLZQSGLNa8byw3Ns7Kri
         zd/A==
X-Forwarded-Encrypted: i=1; AJvYcCXpliJPM5NNuQL03RZgFk9uYBE262LJuSZlUDtmAHSp3oj10UzbFjn/0IxEhhBYrGEY0m1ZTq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHsqfd1wJfDu7jvtPtQWMfk5sIh/avxn8U7P+UNiM7AsMgjkFJ
	NlqkrsyeoZOvSjvA5n8bwiZOs/a2PwpZgudOC1KxftopxNaWPNCS
X-Gm-Gg: ASbGncu/GGGQg9wbC+1AFZ2fYfr42LIV2+nxyOAF936gMHDCzOAfd0hqFhv8I42dW2M
	hdd/TzXz1+yqJ/wH+DafDFZf4GD7EmgMb4hhwN9PYaw6tSKq5tx8TsYDmXWQent6qLGbl5/zjCN
	a5aQmK4hnWnwdQJWkivVl0jRdkFLJXTqZTrSfZc1eUa9fAhm5itGxA2kT2HCAixB2UPmupAkPQK
	R6BOsglwZNvZ54Ae82JtyVcdVHcDRGiw2aUCpqUDDwS3wlU8dl07AQmvpb7Oj6pz2n/U7hfInsK
	MHMr5paxclqerPiQZQ2dRoVSZVG1UcvbXLu3Ci2jZeR7c69GvoIcRrccp1vheKKluQM5CMXVZ6U
	dh/Up/3RRuIWOcxgQcBqW4LVB+h7rFj4=
X-Google-Smtp-Source: AGHT+IGRpwt7uQ17rSd4z0Yc1/utLPtVZ7i6pW6gVKbRZIpAtRipPkhFS6hlQKY0NPaAyByrtfQcHA==
X-Received: by 2002:a05:620a:1984:b0:7c0:c332:1cdb with SMTP id af79cd13be357-7c9619e853fmr948053785a.38.1745679353604;
        Sat, 26 Apr 2025 07:55:53 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c0aaf910sm35369986d6.107.2025.04.26.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 07:55:52 -0700 (PDT)
Date: Sat, 26 Apr 2025 10:55:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 andrew+netdev@lunn.ch, 
 netdev@vger.kernel.org
Cc: Madhu Chittim <madhu.chittim@intel.com>, 
 anthony.l.nguyen@intel.com, 
 willemb@google.com, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Zachary Goldstein <zachmgoldstein@google.com>, 
 Samuel Salin <Samuel.salin@intel.com>
Message-ID: <680cf3f899896_193a062945f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250425222636.3188441-4-anthony.l.nguyen@intel.com>
References: <20250425222636.3188441-1-anthony.l.nguyen@intel.com>
 <20250425222636.3188441-4-anthony.l.nguyen@intel.com>
Subject: Re: [PATCH net v2 3/3] idpf: fix offloads support for encapsulated
 packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tony Nguyen wrote:
> From: Madhu Chittim <madhu.chittim@intel.com>
> 
> Split offloads into csum, tso and other offloads so that tunneled
> packets do not by default have all the offloads enabled.
> 
> Stateless offloads for encapsulated packets are not yet supported in
> firmware/software but in the driver we were setting the features same as
> non encapsulated features.
> 
> Fixed naming to clarify CSUM bits are being checked for Tx.
> 
> Inherit netdev features to VLAN interfaces as well.
> 
> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> Tested-by: Zachary Goldstein <zachmgoldstein@google.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

The issue resolved was that checksum offload support was advertised
for tunneled packets, but not implemented in (some) firmware.

Support for tunnel encap without checksum offload (e.g., plain GRE)
and even GSO_PARTIAL may still work. Not sure. If so, that can be
reenabled at a later date.


Return-Path: <netdev+bounces-244451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B839CB7D07
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 05:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DBE7300FE18
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 04:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E196F2EC0A3;
	Fri, 12 Dec 2025 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="tm62fkmv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EBC2E093F
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 04:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765512030; cv=none; b=k4jnu3JgdbnmplKOZzKbTiTNaoURbRCw9K1znwFnHgO7WZUXQ3lb40nyR0rfXPEYOpLKX+y1Wj4SHJ13D0MBUKEWHURigdU2FqkoKqC84Z8nZlbHuFg0Ie4aeJoVG06LwcTf0z9aa0BRfFGcqYmuWU/Ub/Nvmvfct4HY1R4ir0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765512030; c=relaxed/simple;
	bh=jMmmWJOEHOjpFM4kn/vYckPigFDxsbPEd4OVO16MrfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpRWoPT4DGjR95dkLFGYBa0OoUG6CE+KdC146tWNxvzEkorCEDltgAkgywRAXiHmfxI2pCkKaqGgv1LPbl/yZN3TqMzbhQg+8jGarFdShFPYdUZA6+USXyaGKQwFMC+2LDZPzQ89ZNG4TKTqfZhkIRHfkYOK2JOZ7i47yIf873M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=tm62fkmv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297ec50477aso3352585ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 20:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765512027; x=1766116827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZqZ+z8tvqhGcBaviDEqLLRZIh7wEbMOsq19107JFIY=;
        b=tm62fkmvPrJG2IbIm/0icJwDjErIXKgknUF62/g9i0/uS/slEJvZt0jOReNmSLInK+
         eeu9BQ1TZIbypjTxK3A6yCnTnwxl6VYKB7MIa8Ql/HgobZ8ovPuva4u4s5bC/NyziGDY
         pGMCQRhc6rWQbqx3oXN/TklV2cWn0H6OF9W0WpPOHnhbej1aAuQNUOE3qoiKsvltATjR
         AcLux59Hr84jZz3VhOt/ckJBFmTSio7l0tiXB4iiDc2ILW+rOjxEGV3ddsoDpobHRVDq
         vW1E5ISdiOz4a6ZKe0ds7jKygmCVStjFp/HodJEAC1Rcob2NBVQ421jOPSkPH1Y5wFIl
         WJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765512027; x=1766116827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xZqZ+z8tvqhGcBaviDEqLLRZIh7wEbMOsq19107JFIY=;
        b=pne9XQpl9djlcBxQyLSpY2m1tv7suX731Hw63P19PMdAO4uwbtse+YQk5HWPsGMDT4
         LGC8BKickRkt1UWPtxPV9W21TB5RPvlYcUg/7Ih53FtNGvpDR1XdOyP7vCKaS2asD55j
         f5DvgIIn5RpdvPpM/A6GR5XnqXNwL1bWS4C78pqVaOst7MTMJuWbb405we3rpLGX57ZC
         O5J7Fr0r3wL4/HBd1siJtP4QivxVtpyawiSiKbe2zExfok+bvgFbCPTscspKjfLVfcnd
         Xypdu3R6H08NTcggrngTOdO7g/hFgEdAZ24n5f/mGsunbT4NHj9BQ9J2aGOGGzbgIpop
         FB4g==
X-Gm-Message-State: AOJu0Yx+vMPsOnD4zVqrjHwkvW5w5ysoKLrG2UsTffgVbDE5iOFoK8Hb
	bsKelfrwcJywmVVfhlQsoBAr73dN5gv1LJJbQKHGt3xx9otcJqIDquAblFPObxFXBrEZuqTMt++
	H7V4EH0E=
X-Gm-Gg: AY/fxX621n8BeId5MGg5ViAb+9mxlTXQNzzTckJbvGV0OhRBv1RRG1D2k+qAAlDgkoF
	fElx6hFZo5BXr3FSibkCft1hTmTHBH0mfqUowZMtJshD5vNEvnRVXPot7n60AzsTHzd2MnsQTe5
	okanI2T+DVIggJrsaRciFESSiAXtBXmTM6NiIpIKddy4XJiWQxImzP8vj0EbzRwDktJCa0mXnv1
	p68XAmX7jdBZvV5XH3haZnUvS8z0pFmABlI82gvuy1swBO0ikR9HTidDpGTeE7vYzzNL7jwcITj
	JQBp9VUSLAma006nVqKnAyjl3kf6bIf46SuffzKPDrrLnrY8vbynRlbcwEUjInpjwTs1Mj81b6z
	MwyQAhW2sxzEo2cDwGKuV6kW+Tb+8SIJiSJWQYsl6FyM5uZ/RhIzjvA2Hy8UJIf9iNBlCz1m2S1
	ApOcLRVYuAERqNySZwQb29o4SBewk5Ug==
X-Google-Smtp-Source: AGHT+IFRbKb6VOolGB8sxGAqY8rX+DGNIVRNd5fDq/AoXQEVgEmgw5At36RpkzSO+x43Gv5S/EhoJw==
X-Received: by 2002:a17:902:f70e:b0:29f:1b1f:784 with SMTP id d9443c01a7336-29f1b1f0a06mr15420055ad.4.1765512027382;
        Thu, 11 Dec 2025 20:00:27 -0800 (PST)
Received: from stephen-xps.local ([2001:f70:700:2500:cb58:a2f0:9144:fccf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016c63sm38001065ad.48.2025.12.11.20.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 20:00:27 -0800 (PST)
Date: Fri, 12 Dec 2025 13:00:20 +0900
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Eric Sun (ericsun2)" <ericsun2@cisco.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: bridge-utils: request to fix git tags
Message-ID: <20251212130020.7a555eb3@stephen-xps.local>
In-Reply-To: <161B0C34-1F18-4010-B89B-738DA12F77DC@cisco.com>
References: <161B0C34-1F18-4010-B89B-738DA12F77DC@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 02:26:02 +0000
"Eric Sun (ericsun2)" <ericsun2@cisco.com> wrote:

> Hello,
> 
> The bridge-utils git repo [1] has several tags that cause recent-ish git fsck
> to fail with the missingSpaceBeforeDate error [2]. This is frustrating when
> working with github, where such cosmetic errors are not ignored by default as
> they are by other platforms (e.g. gitlab).
> 
> Though bridge-utils is deprecated,  I was hoping somebody with access might be
> willing to fix up the tags?
> 
> I've verified that something like [3, see: "How to work around that issue..."]
> address it correctly.
> 
> Thanks in advance!
> 
> [1] https://git.kernel.org/pub/scm/network/bridge/bridge-utils.git
> [2] https://git-scm.com/docs/git-fsck#Documentation/git-fsck.txt-missingSpaceBeforeDate
> [3] https://sunweavers.net/blog/node/36
> 
> 
> Cisco Confidential

I can see if this is fixable. But sometimes old stuff has to be preserved


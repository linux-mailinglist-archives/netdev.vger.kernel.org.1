Return-Path: <netdev+bounces-238842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B49BC6015C
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 08:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF2EA359B71
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE9199FBA;
	Sat, 15 Nov 2025 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzW0R3+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1F2AE78
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763193534; cv=none; b=czSpdxLRdjk9OUL+cQK1KXCVR9KpHVfiKq/BfL+XgIcjmPH/cV3ZrM+PqA6Z59AjSKDOEI0W0OKu04trBHIm/MNA4w2WrCq8FS9OuYlzXVFBkTyPOkTKvrynRWBbxNV0l3ebXoZR4egnZ6YWRZ+1Pe+xgwV8K04XmdwFIMunQvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763193534; c=relaxed/simple;
	bh=7IA24hssfbm9kgS+7AETJvRObZ5S/rQnPGOyauw47VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGJWAn4Ijh3M3hh4ek1lN0kfUiiQx3wdccsX7hxLH762wL/wpqzuF9uDuKJ5QsraEWyJ+5+/3WxWSz0a6HzrhDzyFB/P/9TO2RjPt12+UQWwU1ncsc4SsX/eUO2rj/9ozz3XJMXRV6OQogR1WLs2UUpeDXb3pOFzP+HaMj7sC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzW0R3+e; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-343f52d15efso2299348a91.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 23:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763193532; x=1763798332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MF0CNlB09dDx8CZgE5eg3pyjdHElMh021rKPfz1W410=;
        b=OzW0R3+e0oa+av7r0wlfZt60wp2JakbpSIdq0xD8yB9cs0C8eh0ADZQQVUUl19nML/
         QA6/IO06HsAlw76MJ5ZoNcF5HDrvxJkp8/mQ69UjCi70/pe8yRqw+j9QuqGzTVADtx/2
         ua2iQMjBWYqMVwFqFWz7eHznHeIV9wJ22P+qIYCK5h+jJCX1GByz7JGtuFI/akqHqRTX
         nuDgNxz5KpTnhuQY8PujU/l1c1oGqDEIRJ2yK+aLC5AkWxX+t/E2gvOBC6W/XjP1lEE1
         jMUEx7Vi7S/NaiSPRGUQspjZ/h2zTqt88htJmIDZctQTW5KJlgwBP8So83B6dGJz216K
         q3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763193532; x=1763798332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF0CNlB09dDx8CZgE5eg3pyjdHElMh021rKPfz1W410=;
        b=TaLozBS8OYrlkFrbOJMJQ1VMhsgTxheWODe58CeIe1bCRPjjuyeGk0vaJqRFgOveDO
         VeQtTyUtcc8w/luaZtgd7s76PqBo4Os/Xz3kxhy7A1X85mFyXhGa1NFhP8snbQC14+LD
         kl2bhouKBr8Lilu+x5RIyLjlrtt9NDIMMTWW9XFK9y9lC8c+RT7UmJ/gTMo1G3w1ucL9
         60Zo5y/zbAde2gFtGDfpKZlfnoZVVedcoHO2aWfUIIrkR3U6HtL6EKPLFvbOAMo6a++I
         hd7/gEo+Fpy+B0mye0GCBDfB/l6CS4PuumKFlvuvHexi3Gu84rMOqrwMeJx7do2Nk4PB
         cahA==
X-Gm-Message-State: AOJu0YxA11cim3p/OyXnXjOZX0GOvUe4d9SGnY+HGPrT3MzBUgBbiqmE
	inPzgWEhEwrQW9C3Yt+35xK4AgfYUflwHvZ0QzZAtOgcV3OZ7hgc9Cwl
X-Gm-Gg: ASbGncuYAwLcCRy4vLUmnYGF8THYn8NHvDeG79NZy9CEipUVTfUW71KQOW9zg4Nnhw5
	Bxj/deE2fD8G7zZcQFuvDu2Van/UFoZPP+H1ZiD9QD06GduYXhrEwsPhLmEzuaIo75DBhAopeSS
	3cwSJOnIA01ZDJNHc0jdZFgsBkrw3P9IWV0c0vbK5kluy8ZQXF7v7Ft+dsoFIDhJMjOtxIKo9U/
	u5mX427JDARo5N08YCBacWWjqzMgrz46dOipCZRZLF+PrUZVZVllfn61lw2vhMicNCOdRdCMY9l
	o4kjvN5xB+GsLEcfH/pfk0s0ftav1dAw3h/YxWrvVwkdbIOUQXB1urdxbYrpiq2EghZHa63kDq5
	Aw0ed0U3mc0XAvm6s+wugmN0e8G1M/N2znGrd6+VCSbWT7f4hi9/P/CueUVkLvEvQhKCEws7HJC
	O4HJP8K9VD2HU+/4ZAMlVspczxX7IOxgAieq++uA==
X-Google-Smtp-Source: AGHT+IF5RfVfdoSR8epRBvO25wL7MVlPY9GHcuOfhGeoJp77hSo38v+4EuRhPqUWE1eLEn1PhRthJQ==
X-Received: by 2002:a17:90b:1d0a:b0:32e:3552:8c79 with SMTP id 98e67ed59e1d1-343fa73faebmr6776084a91.29.1763193532599;
        Fri, 14 Nov 2025 23:58:52 -0800 (PST)
Received: from lima-default ([103.246.102.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07156absm11518522a91.5.2025.11.14.23.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 23:58:51 -0800 (PST)
Date: Sat, 15 Nov 2025 18:58:41 +1100
From: Alessandro Decina <alessandro.d@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aRgysZAaRwNSsMY3@lima-default>
References: <20251113082438.54154-1-alessandro.d@gmail.com>
 <20251113082438.54154-2-alessandro.d@gmail.com>
 <aRcoGvqbT9V/HtoD@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRcoGvqbT9V/HtoD@boxer>

On Fri, Nov 14, 2025 at 02:01:14PM +0100, Maciej Fijalkowski wrote:
> Woah, that's not what I had on mind...I meant to pull whole block that
> takes care of FDIR descriptors onto common function. That logic should be
> shared between normal Rx and ZC Rx. The only different action we need to
> take is how we release the buffer.
> 
> Could you try pulling whole i40e_rx_is_programming_status() branch onto
> function within i40e_txrx_common.h and see how much of a work would it
> take to have this as a common function?

Just before I send another rev, you mean something like this? 
https://github.com/alessandrod/linux/commit/a6fa91d5b5d1cc283a2f1faa378085c44bda8b4a

My rationale for i40e_inc_ntp_ntc was that _that_ is where the bug lies:
letting ntp and ntc get out of sync. By introducing a function that
forces you to _have_ to think about ntc and explicitly pass NULL if you
don't want to sync it, bugs like this become less easy to introduce.

That said I don't mind either way! Let me know if you want me to send v4
with the i40e_clean_programming_status() change.

Ciao,
Alessandro


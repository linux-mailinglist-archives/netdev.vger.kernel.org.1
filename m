Return-Path: <netdev+bounces-118470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE40B951B62
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA3B1C209B6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048F31B012C;
	Wed, 14 Aug 2024 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FjNY6uJC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AFD1AED2E
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640850; cv=none; b=SWfCbgCEzYTL8uE5G6/eKZ9/SqXYgSNmXqcOWs23iA63j9zFPQk5n8vMESwdOuKnA39vNGDfpD1WVUT9+V8nH9JGMnuRYisIOvbRSeElPnO0Zy9hb3l99Pp5VmXFxADDh6gJDEElQakope4zJXHTDNV5TYukjQvYnKDAkWoCn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640850; c=relaxed/simple;
	bh=kfJnMvtM2vLm13RiX4qvP0IyaBUHN4/oS5rqRUM2LqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTIi34Wx8t2iCiL06GhqjSBIWI70Epj2t+vIpCGTzZ7KfUP6PcfW8se3MruphTrTg+4TnhNspj6BGqhApKDhI0p1lXlBkbS0BqzB2nhrI6uOFdJIPNDJKHNcop3IoJNauEaU7w5Xnb4jwzbxzrX1eS1DIPJ9CVTyMzkTAK3pB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FjNY6uJC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc4fccdd78so48523815ad.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723640849; x=1724245649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBzYnhuz+gu1wdKqgujpah1m++RYG0U+nMnNTII8vEw=;
        b=FjNY6uJCadAsCGCFPljDVKvupyd+RQkvdjiZctIyc+g1g8ov09NET9kl09Fb4iJq+A
         cyyKhojaed3SRgn/nJNge6GPuHi6NyCQxi5aKGPt1H4Li7DWaaVwP9vYr9aAtg3QFsxp
         DSfFfqio2xvZnT9Mkskvq7Gm/npCjLv889aCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640849; x=1724245649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBzYnhuz+gu1wdKqgujpah1m++RYG0U+nMnNTII8vEw=;
        b=aY/Fs0jUY80xm5goThr35ACzXNQTbJoPGt8bOCGBOFckam/21PpzA61tnDGimFyJ14
         7xUtOa8XdhsWqIkkJxtfFfLzH1+Samp0zjO8SHTjWPZwfDVS4zQbu/ca3pc7gxuRON2c
         L1Yas4m7D23BZUVHkPDC3EZWcLnGtB3KRSTG2T901Pug+i1cNHnPOZTAQk6RSDefmr2z
         gwIA27t3pJ1yfv7ogNVrZjmkuS1DYJ0m/PPs3C1cpQ3Lrn/Y3YvvGYZRaYOiAgSwH4or
         RiLvU3QqdD16Mh+hjipyKgXNh8EYg6KkjvrJQKu9t/kTXmf1UEvxO8m1t2jmR5GGCqwJ
         1q/A==
X-Gm-Message-State: AOJu0YzK7CTbh3VAvtFjWotVKirwBcNZCGZ9HrlVaHvkWNBd+Z4xMj2o
	qG12ghudoPDxngOfBeIsxEnLB1ZNlKYpj4U/MzKwNcjY7FOIAw53o7TT8/9MeA==
X-Google-Smtp-Source: AGHT+IEUgAMKNNQES4lBZOmtpakrDHXDWjrtKDVejz42vwA+CTi5zO2wgmhi7uHKScY7fAL//X/S8A==
X-Received: by 2002:a17:902:c403:b0:1fc:726e:15b4 with SMTP id d9443c01a7336-201d63bcc4fmr33303185ad.28.1723640848763;
        Wed, 14 Aug 2024 06:07:28 -0700 (PDT)
Received: from noodle ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd148f7dsm29358495ad.89.2024.08.14.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:07:28 -0700 (PDT)
Date: Wed, 14 Aug 2024 16:07:14 +0300
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: Re: [PATCH net-next 0/5] tc: adjust network header after second vlan
 push
Message-ID: <ZrysAhVp8AaxPz4b@noodle>
References: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
 <20240812174047.592e1139@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812174047.592e1139@kernel.org>

On Mon, Aug 12, 2024 at 05:40:47PM -0700, Jakub Kicinski wrote:
> On Mon,  5 Aug 2024 13:56:44 +0300 Boris Sukholitko wrote:
> > More about the patch series:
> > 
> > * patches 1-3 refactor skb_vlan_push to make skb_vlan_flush helper
> > * patch 4 open codes skb_vlan_push in act_vlan.c
> > * patch 5 contains the actual fix
> 
> The series is structured quite nicely for review, so kudos for that.
> But I'm not seeing the motivation for changing how TC pushes VLANs
> and not changing OvS (or BPF?), IOW the other callers of
> skb_vlan_push().
> 
> Why would pushing a tag from TC actions behave differently?

IMHO, the difference between TC and OvS and BPF is that in the TC case
the dissector is invoked on the wrong position in the packet (IP vs L2
header). We can regard reading garbage from there as a bug.

I am not sure that this is the case in OvS or BPF. E.g. in the BPF
case there may some script expecting the skb to point to an IP header
after second vlan push. My change will break it.

> 
> Please also add your test case to
> tools/testing/selftests/net/forwarding/tc_actions.sh
> if you can.

Done in v2.

Thanks,
Boris.


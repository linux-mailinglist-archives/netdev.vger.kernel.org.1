Return-Path: <netdev+bounces-263576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E7QFHaop2kqjAAAu9opvQ
	(envelope-from <netdev+bounces-263576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:35:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC001FA6D2
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DADD63040FD3
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 03:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C297366DBE;
	Wed,  4 Mar 2026 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="V/RVqeIg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15127366802
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595310; cv=none; b=S1cLPM0c0p3dGuYiHBpsMuPqYLanwhqli3+vQwMn1yWzoGn/lhoo8OwGs8P/fyqXpwqWHcBG97Q4vyTeDTpQX402Hol3i92D+m3vDOL6Ihp8u46ZOWIhhFBG/LiQv1Plk6yDzQUMkEWoSRher6/nk71TV+hgVdNbOC3zbZCM+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595310; c=relaxed/simple;
	bh=XLiJ2nD8DJIVsSYbftRzQJ/qqbqmFgul82tptWrTWOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLYgtUtzgQw/Cy6q3zLT5Q8xAcePEW+vJ0VwrnJwlqgD+zdGma6Ov6s+6otTpNvAuE9U6XbzTsiCSKSLnsmVPw+sb4OstljY9QZgnxjLWPuOK6SbbO5j86SyRVHfyYR95v0KX23Y3vqaBlyvPNRkGSI7sn2EI4pCbbe9PyhJ79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=V/RVqeIg; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4c383f2fcso4377071a34.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 19:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772595307; x=1773200107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=;
        b=V/RVqeIgbll4o4ue74s/NYWOyn6ZZujuTFopUtqhjail3GEAE5/viHb45qoLBheA0C
         FjThpB0c+lktkioT8cLcDCupPIwr6ZtFjugZdaWmjPYCZvExg28dp2j5GNZKC+dwFIRT
         nMYTLvuq7I98ei43l1fO8SZa0kkKx926Q5k3OSaMudvEhiEEeEmS0+UTFtTKWPCx5BtH
         jppJ7leZ920nl2rr1NSxO3EsCbm7kJQgCQktDg8tjxpMgjzbh601eaHfku+ZFLcNfn/I
         i2IKtcx8h6KQ7DdzF6qyt1xEaUJ+G7gmzB4DX6DIGKuctT6KVr0ZXVqee2uy5eeWmU1x
         Tdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595307; x=1773200107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=;
        b=W/GBddwqZ0EPO1wDJ6Ghpsoy1zbFrD8FPz2pHEBadEiyPnqsqoHbMBiXCC7FlCrlVM
         X94ZRoQ2CvQ86T9yfMLptO7zD6NxNxnbv/tK5LCa+LV4R3luJcbUKzWR8tQRUCNoHdrp
         CMyiVU/6A1jgEZT9JTkTF3+APakuxWZBwkvH81WvTS2Tds6es6h0jI76YXDBNZVXqlH4
         Id5CqY64YuANMPSiSOHZSeKzZOoqhxh0FgMPacAYgYp28gqtkG1Qn9C7aHQ+Wqn0phaG
         jldUcyWNzipNmmX2eSlBzZ7IkOqKkkkV4ERNQxmwwe7CWvaLHrTtoBB7KAIltTo4lveS
         jFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwH9sBpBSRrtVPVOQB48wXn+KmYh+AQNsY6UBLBYQsD39lokxtFcsQfXb6UXOathYSF5rfX+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx0VR6jnjA5RTfLkyxY6wqnEHeqcX8yWvNIgQ6pWdG8elUFr3v
	J1aD7+qQZTc4O55cW6EEAhSeiGTie1Xn9FQfRIasY7xIlV3ZYGHUBCoENVLWnkHiOCI=
X-Gm-Gg: ATEYQzxvGNfRnqjDPaTINYv1HG9iJgiKhGqzr+GegVqJMM/j5fC32hW9992bpo24cic
	dtxVEAhnShcy87RssbKJqU0wVxJREHOgj7JF5fFoSGEZ7O9KUX53tHVcXZajRYPUjJChy9UrpkC
	Q7kgQLTpJ5JKgLR4BBZKVvPpeNqKSaWdWwPK8K4ORJbe/RlM/thLQ8/FTeQG+KVFHArbQzP0JmY
	E9ds85NYX/nmpM6GtokPwu00FfjY03yAztRZekzaXgazNbbdQGtchNH2Kz0eIHTfLVbIqRRTcmu
	wi1Z8JTSBCrQ7lUJCcN7rKnrIs1Sx+osvObmQqQ5CfmrtB9BVJackyIzL0Psp5Nxwc1mKbCX16g
	gIQomk3vs2ie0YDe6RDWvHbbnaBybDxzx7ORpsU4lGom5B/XqX+yGTbkGMCRDYommAsL5yZGkph
	FE899UXnz1OLWSFl/0fPKLErR3AvdfL7ZI27UKusa5//KiMt6/XqCunk6ZbeOME0Bd/Zg7ZGtd6
	zUMn42zAw==
X-Received: by 2002:a05:6830:6185:b0:7c7:6977:17cb with SMTP id 46e09a7af769-7d6d139f788mr450044a34.21.1772595307034;
        Tue, 03 Mar 2026 19:35:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586653f6asm15202012a34.19.2026.03.03.19.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 19:35:06 -0800 (PST)
Message-ID: <e96e851a-9050-4d8c-b1e5-bc3b5d91a84c@kernel.dk>
Date: Tue, 3 Mar 2026 20:35:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] mm: globalize rest_of_page() macro
To: Yury Norov <ynorov@nvidia.com>, Sean Christopherson <seanjc@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexander Duyck <alexanderduyck@fb.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Anna Schumaker <anna@kernel.org>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Carlos Maiolino <cem@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Yu <chao@kernel.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Eric Dumazet
 <edumazet@google.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Latchesar Ionkov <lucho@ionkov.net>, Linus Walleij <linusw@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>,
 Namhyung Kim <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Abeni <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zheng Gu <cengku@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 dm-devel@lists.linux.dev, netdev@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, v9fs@lists.linux.dev,
 virtualization@lists.linux.dev, linux-sound@vger.kernel.org
References: <20260304012717.201797-1-ynorov@nvidia.com>
 <20260303182845.250bb2de@kernel.org>
 <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
 <aaedwFwXh9QXS3Ju@google.com> <aaen2pGs0UeiJqz1@yury>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aaen2pGs0UeiJqz1@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EBC001FA6D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,davemloft.net,redhat.com,mit.edu,eecs.berkeley.edu,fb.com,linux.ibm.com,zeniv.linux.org.uk,dilger.ca,lunn.ch,opensynergy.com,alien8.de,arm.com,linux.intel.com,gmail.com,codewreck.org,linux.dev,google.com,gondor.apana.org.au,perex.cz,ionkov.net,ellerman.id.au,szeredi.hu,dabbelt.com,infradead.org,intel.com,ffwll.ch,suse.com,ursulin.net,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263576-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[85];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:mid]
X-Rspamd-Action: no action

On 3/3/26 8:32 PM, Yury Norov wrote:
> My motivation is that it helps to simplify constructions like this:
> 
> -               loff_t cmp_len = min(PAGE_SIZE - offset_in_page(srcoff),
> -                                    PAGE_SIZE - offset_in_page(dstoff));
> +               loff_t cmp_len = min(rest_of_page(srcoff), rest_of_page(dstoff));
> 
> Or this:
> 
> -               if (folio_test_highmem(dst_folio) &&
> -                   chunk > PAGE_SIZE - offset_in_page(dst_off))
> -                       chunk = PAGE_SIZE - offset_in_page(dst_off);
> -               if (folio_test_highmem(src_folio) &&
> -                   chunk > PAGE_SIZE - offset_in_page(src_off))
> -                       chunk = PAGE_SIZE - offset_in_page(src_off);
> +               if (folio_test_highmem(dst_folio) && chunk > rest_of_page(dst_off))
> +                       chunk = rest_of_page(dst_off);
> +               if (folio_test_highmem(src_folio) && chunk > rest_of_page(src_off))
> +                       chunk = rest_of_page(src_off);
> 
> To a point where I don't have to use my brains to decode them. I agree
> it's an easy math. It's just too bulky to my (and 9p guys too) taste.

The thing is, now I have to go lookup what on earth rest_of_page() does,
whereas PAGE_SIZE - offset_in_page(page) is immediately obvious. It's a
classic case of "oh let's add this helper to simplify things" which
really just makes it worse, because now you have to jump to the
definition of rest_of_page().

IOW, just no.

-- 
Jens Axboe


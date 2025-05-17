Return-Path: <netdev+bounces-191254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700D8ABA788
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B4877A717F
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D2272603;
	Sat, 17 May 2025 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4taSLR2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA8256D;
	Sat, 17 May 2025 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747445075; cv=none; b=CxpCoDS2Y4wkrgw1gE5PUbxctUe6Ntx4UgTkvkrunCGsiKnvKWHFcZ7UmZTjR3ojkNxa4ZxfR+qHKnAYAgdudiRYJxCJq9yiIOH/Ifgx94dQ8q8NhFR2UeSF1tVjY3i4wdJy8hiYKaBB+lJ/Ete8n4nfms0/JW4LhcvNoTu3YUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747445075; c=relaxed/simple;
	bh=iEwuUeRkbbHEfbGzSvu9NeXyWvFlldxRXoRnyTNNrRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCq8sWZNiIQX6Wly9yzBm1hoYtKx61oejH0fvemRLeHV6aPGqM2gaauqkStnfFBZyDN++Y9XX1S1cFmbxnqXUHMkz761vtvvhy5O7hgaY42fko3r7NOu+OnYXhEYPpLYhNv8PbH1r6m5EfDBbsdw8ZcZqBaL8kUHflTZHHAwPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4taSLR2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30ac55f595fso2616428a91.2;
        Fri, 16 May 2025 18:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747445073; x=1748049873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBc63I+Q3cuB4vlH4Nr3VmPuUHCAFqqeXKbaborF8e8=;
        b=W4taSLR2fGwPi+ThDO58p9qM9PFjg+eQbUtskY01Ci/BEWVwVaparuHodWdXNYU071
         G3W1EiB7P2dQYqJ4KwLMdV/ZvbNS0yjD/haL0uRBF/dVkEr19sHuHBBOXMDrbNr47f8r
         U4XETu1MqBD0PL6yHihSYXcvCo+uIVHHlvDvcz+XMNWeOaXHCJSeUz9Q3HTpU8SuOYf9
         t9CcdajQtTXjJqn0ltpIY+ptzKdG1dKg1XpwYibSfeYD/zeAZH3uGFim2X9WM4YXZYro
         CNnUq4DCQo1Ax8ErQzKn6rl2mfaq13rrnBcEp7UZa5N8U4tws4DRVcPO28/ZZn6m3nwp
         28XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747445073; x=1748049873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBc63I+Q3cuB4vlH4Nr3VmPuUHCAFqqeXKbaborF8e8=;
        b=bGHZfoLv4mFyGXjQeuE2viZg/RA+TiDaDKY6ot3FOXmZVLYk+WCF7wNU+txdqLu362
         efSMrp+mb/99Z+Rql2q7fdW86D/GjYlI+ZlkYZozsW04NR30qC8hmIzDZfvATcnKHtgt
         7o3ap78BP9Pdj1fEnIFWrL8REdP7Y/2AUkCSxIvycQnJgWKhMVImj2dcCv2wDvlpnoR9
         y95n1hHoSmRyiH48Wx3vymb9NPqqFLO9qssjcNMC/HipU11UZQhxdQgw66p68FtLR+7t
         j0mU/bjOB5Zd7OmHYsMVKOSEsTQuTslLRe/jLIliAOihtLkpomh1SJq3qILqPUwGQuJM
         9bbA==
X-Forwarded-Encrypted: i=1; AJvYcCWpmj/gpM4Ht6uaDjFgpJmBtyuG5ECD4KtXFo4nb7RerQr//BzTVn039WWKkiKOT7xnWKRdUL5GPClgD0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyty0yEfxnPxeaaP3Vr/uj6jZJiaPb6Zr12Okl8WatntDsh+EQx
	x19dkgLCL2OuOrbDtYg0A27HesNnt+hXUP7QyyFvkXHl/yxBexPUQV8=
X-Gm-Gg: ASbGncsgq5kb/LnrDQU1DINPolrjUtEAlOs8EQZyXMa6qvBZbgckIp9MeFpvYygMbsN
	NMUOt2DhxdCtQXHHeO3UszUZaXK4e+mjqzuo3uIb1cgja25mr07VxEZBK0dgGkaX6BRGYurGdKf
	3i9B2Q3kbYXTF6vMbfGDjAAnm/hw4vZLSTfz2i4d1nBZdfj4HrG8M2fzKD6xMODSU0wOwFtlimY
	MWrf2c18CxJSJy99HSPOvdtJuGHEGrc51bfpYG4xJjzxAqn/9v5kbXsoWCELOb7NHyclDjV2qNr
	bv7pMiq+hRywE8nkEUDwIfV+1chYeoaFTMaWDeOLoDUr7roLKJbTj2n6OvdK+XaH5/DvuF3To/4
	ZQcYLaRxXO21v
X-Google-Smtp-Source: AGHT+IEMhNGN/EXKXarwlTN1pRGlevWsOAlRWtzgXGvry6NzyLwm9JZr3drV32ymRYId/IXM8bZYqg==
X-Received: by 2002:a17:90a:d604:b0:30c:523e:89e3 with SMTP id 98e67ed59e1d1-30e7d520e3dmr8489043a91.11.1747445072763;
        Fri, 16 May 2025 18:24:32 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30e80704f7esm2086256a91.24.2025.05.16.18.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 18:24:32 -0700 (PDT)
Date: Fri, 16 May 2025 18:24:03 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, sagi@grimberg.me, asml.silence@gmail.com,
	almasrymina@google.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: remove min_t(iter_iov_len) in
 sendmsg
Message-ID: <aCflM0LZ23d2j2FF@mini-arch>
References: <20250517000431.558180-1-stfomichev@gmail.com>
 <20250517000907.GW2023217@ZenIV>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517000907.GW2023217@ZenIV>

On 05/17, Al Viro wrote:
> On Fri, May 16, 2025 at 05:04:31PM -0700, Stanislav Fomichev wrote:
> > iter_iov_len looks broken for UBUF. When iov_iter_advance is called
> > for UBUF, it increments iov_offset and also decrements the count.
> > This makes the iterator only go over half of the range (unless I'm
> > missing something).
> 
> What do you mean by "broken"?  iov_iter_len(from) == "how much data is
> left in that iterator".  That goes for all flavours, UBUF included...
> 
> Confused...

Right, but __ubuf_iovec.iov_len aliases with (total) count:

union {
	struct iovec __ubuf_iovec; /* { void *iov_base; size_t iov_len } */
	struct {
		union { const struct iovec *__iov; ... };
		size_t count;
	}
}

So any time we do iov_iter_advance(size) (which does iov_offset += size
and count -= size), we essentially subtract the size from count _and_
iov_len. And now, calling iter_iov_len (which does iov_len - iov_offset)
returns bogus length. I don't think that's intended or am I missing something?


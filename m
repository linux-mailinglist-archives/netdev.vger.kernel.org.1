Return-Path: <netdev+bounces-181358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C4DA84A5A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C319F9A0C2D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769581EF09C;
	Thu, 10 Apr 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z38Uv19x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFDE1EB5CB;
	Thu, 10 Apr 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744303506; cv=none; b=hzTN6C8nYYi6k9CQjzCJH5hPXozSwXSyaRtGR3DcyxCeGsT4tCW4cVhtkiMRxVdRGOqA07cYuoETJu7ILh9FNfkDEpF9J71JXnAU7EXXm+7Ei3Rv/kN54WFyKviFWgep9ITEB0yId72sDm3PcWmNWnPlWoh0RKsA30ldJJdt5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744303506; c=relaxed/simple;
	bh=GWcSizNYU1gg0XEATe9BThTR2b6N6lRIrMAm+5bPw7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KItDhsAZVyWItavhFa9AmK/GDnFA2YoJMSRcfj4Zit3SUwigHOvAXCpc6PkCLjGVLzmai8q+0KinWeas69e8/5+Uv79tTatMbtoeXI5iczFYErsV6h+sqMr0fLJ53lQIs0o3Hlo6g7fv9LkmYyIXfZ5pV00UgURRRfllFWn56Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z38Uv19x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224341bbc1dso10304795ad.3;
        Thu, 10 Apr 2025 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744303504; x=1744908304; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fAFdQr70FiGQ92Ey2RsY/HESGSNDTxY19XNdpks48EU=;
        b=Z38Uv19xgqyPJcJThK/qTXBS0GyLuplzGHGKaz95r0xup3VhqSHRN1H9YhzFoHsh2x
         np4Tb7MWF8ZEVDsQymMnwa7Kefw42ibGZ9lz8W+3PUVa4FaCc8Br6N/SY5kw2GEKdVo4
         qlf3KUDQ5QmgyfPbSQrCRVbD6wN2SgpwWFwdmb1QD98eXW4RCLK35yeNT0PT8+K2tDBM
         WZ8mdKd7F8pIjgWkeh0ck9A0iNy58oToXCBYfESoa8mVpD+HATEsUrSe9JthCKIi73rd
         oL7CINt60nj/gt9Bjh8l4kogjnYdr5urvac2N5VozHdY/FvOqcsmUMsP5PSCTJ+4Yzb7
         9zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744303504; x=1744908304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAFdQr70FiGQ92Ey2RsY/HESGSNDTxY19XNdpks48EU=;
        b=ureML5/sZHxE1+6YcWTEaFAXLhgdf7qikMytyQvnyRPbdCJGi32XtkRjjnwnx4sED4
         fr1NQxVF4je30nwA1g3MjGlExh2nzfokxZ/eZFOn0A949CmpVMtPyfPvvjxD6Yv4CS8y
         mz9aUNrcVb/MKiItZkMgsumqFTpQRYeEXdUffyG/GG6TwhLFtUUWNJFW3JGY0IURKqpB
         LB+O0WPLZS/w0IvWi83Uq6kGvgA0MXIRGXBk9p9CHtEFh4/kAVPxazXrBpJ6Ms1TNbZZ
         /xJY3qlKZXjVxfHod3eEhKZniMPJgjV5L+rZANfdXJdSNgrq7T0BiCo4WYMlMgcgzUeZ
         qkaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFRnUW2lOzQoQreIqsUo5Q4cK/yMtuXVFip32aTxvdCsxG3bD7DGkZL889s2HNwR+aQpWxpc9H@vger.kernel.org, AJvYcCWhZU+wVdpd3byBy+aF6BbS9SXiyoKRpxgTHtBlibqxBdj59oyK3GzJEbaIxQ2Xb4p0dBBOBUHwdB0QVwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziXs4uPISFayDyN2rc0WRmST0ecvvFq9yMZzi/Orn7ut7Exp2+
	BVZUzSKq3tXp9qmdH/f3MFGERx0c10yThsJV6kBIrWZODJRIngND/HQ5dss=
X-Gm-Gg: ASbGnctjhnarnb/heCD02j8I7gRgiIseEMBHM1rUPEd3ZxYFb0GwLfX1pvm4r8dqC3b
	DR4LgmUmGfA3L2+IVFjYIIdzdic5vGrc1Pg1kzoxbN/di+isRsv/Ip4kXa/AdoFuQh4sW/TsqnR
	yGecAVkC4J5UvObzTpmVF8EKFQzbyLmO6Zlr3mzlbmuVmQQc06oJTExDDscxLcgFShBdhn4g0Di
	Yrxz1CSScbuVPcbO8ZBf/3kr4EWSqujC3jNoYRl9nTeNwcH1jp9dYcnGXkF7p4f9eLsoOOobfh5
	Jxm/tUS1VY3AcECa9+XVtQ4p2ntjJzIm58H8y4UsNhXIAkG6b5M=
X-Google-Smtp-Source: AGHT+IHMPnT4uFSTTo+LnFnQ89NhLCpdhzegE5Z2vG0FinoqLrxFTtawVwbZFnRkVFVV59PrFEsVZA==
X-Received: by 2002:a17:902:f60b:b0:227:e980:919d with SMTP id d9443c01a7336-22b42c2d722mr50810915ad.47.1744303504298;
        Thu, 10 Apr 2025 09:45:04 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7b62864sm33068435ad.22.2025.04.10.09.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:45:03 -0700 (PDT)
Date: Thu, 10 Apr 2025 09:45:02 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	ncardwell@google.com, kuniyu@amazon.com, horms@kernel.org,
	dsahern@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: drop tcp_v{4,6}_restore_cb
Message-ID: <Z_f1juV_86Yv9n21@mini-arch>
References: <20250410161619.3581785-1-sdf@fomichev.me>
 <CANn89iJ_CYgP2YQVtL6iQ845GUTkt9Sc6CWgjPB=bJwDPOZr1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ_CYgP2YQVtL6iQ845GUTkt9Sc6CWgjPB=bJwDPOZr1g@mail.gmail.com>

On 04/10, Eric Dumazet wrote:
> On Thu, Apr 10, 2025 at 6:16 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Instead of moving and restoring IP[6]CB, reorder tcp_skb_cb
> > to alias with inet[6]_skb_parm. Add static asserts to make
> > sure tcp_skb_cb fits into skb.cb and that inet[6]_skb_parm is
> > at the proper offset.
> 
> May I ask : why ?
> 
> I think you are simply reverting 971f10eca18 ("tcp: better TCP_SKB_CB
> layout to reduce cache line misses")
> without any performance measurements.

Oh, wow, I did not go that far back into the history, thanks for the
pointer! Let me see if there is any perf impact form this...


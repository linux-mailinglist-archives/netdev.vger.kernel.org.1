Return-Path: <netdev+bounces-127523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8EF975A8E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A6D1C22EE1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB98E1B6541;
	Wed, 11 Sep 2024 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq0Ta0lF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B215E5B8;
	Wed, 11 Sep 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080575; cv=none; b=Rr7rimNtW29qT3CL8z9S9p3MAEPKoiYoHfTIT9ooL2fiRF0vI86FG2rOz0z4Uhud1u8E8cooU5EzaK8GRDPNKG5BLF8+ghXJcuAThcGL+gLyHJoiY1ZvpEr7YkgaNo4axe+FicnA8vJiTeIACT7KU5ONUwPVQvZmm/5wA5st9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080575; c=relaxed/simple;
	bh=T66dp24AzjefhwfW1RczRPfd7+nb/I9+zQXFrOxli7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3erQBhMnNb9cTE89HHsLsZJNcD1yWgV8vp224MB+EOdNmJcs76W7HCaCR7bWz9Lc2iR/CSRYgyXucPcZ66QWrSbByU81BTTh95dgf6fU7I6+r2ViWpTCnfKT9l8QIDU1KWT7WXyzoWq8o342oYZ00h83JBgaO6WuZSbmJ9xCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jq0Ta0lF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2055f630934so1659155ad.1;
        Wed, 11 Sep 2024 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726080573; x=1726685373; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0TkHtqPbdlcbDhsAgIpZTSjTvi+92a07vd3QkuC55Tk=;
        b=Jq0Ta0lFHaZwGT7Y0kTyz6UmFpCijWMxNXSB8buRbn06QF0Vc6AUvXk087rS9eibNr
         yMFzn5gXivq/qwmZuGz+XTcy1ix8uaYqGucw1e0h/WuDC2ml/t5G36uwp5avO5A1ithN
         SBSwhVA7ggpnoCIIJMHVEGFt0y/2HI+xJiua9R5SJ6BB4tHTrsUb28vwi6GPVPs50FN0
         RTz37g8HH00dFafwj553w/Nzg7aVRx6RJH9KIrskR4gNdX1KQSo3UdU+jt9fy2qB2dRs
         DW3aox50FJ7HY0R1ORFvEV7qh8jHHX64whtZeEHx0Tw7qzaEl5Eu5htZoEc884gSp2ZY
         OGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726080573; x=1726685373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TkHtqPbdlcbDhsAgIpZTSjTvi+92a07vd3QkuC55Tk=;
        b=c5JZOifEude/nxhMeHpHLlZpBxtM+scunBLFeOe4TRS4OMlgJTBPtwh5fdhPTa7Bbw
         AU/RYe3taRtGn2tkBnhW6t52iuxnP+aON5nCpDa0ccjF4KPqS4KRJaobKHMeY7AkStRp
         w0NObe9QAfbYqhTwLI5L6/aBfLsaHsP2cvD6jk8wWzSr6isZan6wr8cl4ozo6PIYfFz0
         /AmK8T8+vwq74dreE3k8hDbGBR5byZ6drCrw5y5V4pPtOOkEUN/V818IbZiIES6Ikg7z
         RGw5SwcqmxR+7f8ke+swKso99eWZunCAGNjeqTUxAF0MSF9S08c4kLLRRAYVQqk5Qu6o
         n4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVFYztHxeNGJnxTrqaqkbUEb7cr6kod0GUNkmUPNRFcZMtrf9klsuK7DBTa61Sfh4djqjJ/v8Om1wc58+c=@vger.kernel.org, AJvYcCXg1oe3dyZClJXTuMU/3zEfz4KYjbC/qRTpcOwFt+jITsJvGplQP2ElvygAnwMv2dOk9NGC2hpY@vger.kernel.org
X-Gm-Message-State: AOJu0YxAguo2/ns3n446gbDwHEq/Sq2yXd4gQIumurDwpIEZw8q7w+Ss
	KkPwfuc8FftVWcuYLQUOIxmoAYKmdyURK1pXRmpORwuJUzKcbbY=
X-Google-Smtp-Source: AGHT+IG/AWJKd5HM7CJCBqbMq0zLQul7juhrQIaXgzqktDsTLlkZewVwfXtccotJ+ou9IVAb+UaN6A==
X-Received: by 2002:a17:902:ec88:b0:206:dc2a:232c with SMTP id d9443c01a7336-2076e32fa72mr4669725ad.15.1726080573371;
        Wed, 11 Sep 2024 11:49:33 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b009742sm2629335ad.263.2024.09.11.11.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 11:49:32 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:49:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Qianqiang Liu <qianqiang.liu@163.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
Message-ID: <ZuHmPBpPV7BxKrxB@mini-arch>
References: <20240911050435.53156-1-qianqiang.liu@163.com>
 <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
 <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
 <ZuHMHFovurDNkAIB@pop-os.localdomain>
 <CANn89iJkfT8=rt23LSp_WkoOibdAKf4pA0uybaWMbb0DJGRY5Q@mail.gmail.com>
 <ZuHU0mVCQJeFaQyF@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuHU0mVCQJeFaQyF@pop-os.localdomain>

On 09/11, Cong Wang wrote:
> On Wed, Sep 11, 2024 at 07:15:27PM +0200, Eric Dumazet wrote:
> > On Wed, Sep 11, 2024 at 6:58 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > >
> > > On Wed, Sep 11, 2024 at 11:12:24AM +0200, Eric Dumazet wrote:
> > > > On Wed, Sep 11, 2024 at 10:23 AM Qianqiang Liu <qianqiang.liu@163.com> wrote:
> > > > >
> > > > > > I do not think it matters, because the copy is performed later, with
> > > > > > all the needed checks.
> > > > >
> > > > > No, there is no checks at all.
> > > > >
> > > >
> > > > Please elaborate ?
> > > > Why should maintainers have to spend time to provide evidence to
> > > > support your claims ?
> > > > Have you thought about the (compat) case ?
> > > >
> > > > There are plenty of checks. They were there before Stanislav commit.
> > > >
> > > > Each getsockopt() handler must perform the same actions.
> > >
> > >
> > > But in line 2379 we have ops->getsockopt==NULL case:
> > >
> > > 2373         if (!compat)
> > > 2374                 copy_from_sockptr(&max_optlen, optlen, sizeof(int));
> > > 2375
> > > 2376         ops = READ_ONCE(sock->ops);
> > > 2377         if (level == SOL_SOCKET) {
> > > 2378                 err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
> > > 2379         } else if (unlikely(!ops->getsockopt)) {
> > > 2380                 err = -EOPNOTSUPP;         // <--- HERE
> > > 2381         } else {
> > > 2382                 if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
> > > 2383                               "Invalid argument type"))
> > > 2384                         return -EOPNOTSUPP;
> > > 2385
> > > 2386                 err = ops->getsockopt(sock, level, optname, optval.user,
> > > 2387                                       optlen.user);
> > > 2388         }
> > >
> > > where we simply continue with calling BPF_CGROUP_RUN_PROG_GETSOCKOPT()
> > > which actually needs the 'max_optlen' we copied via copy_from_sockptr().
> > >
> > > Do I miss anything here?
> > 
> > This is another great reason why we should not change current behavior.
> 
> Hm? But the current behavior is buggy?
> 
> > 
> > err will be -EOPNOTSUPP, which was the original error code before
> > Stanislav patch.
> 
> You mean we should continue calling BPF_CGROUP_RUN_PROG_GETSOCKOPT()
> despite -EFAULT?
> 
> > 
> > Surely the eBPF program will use this value first, and not even look
> > at max_optlen
> > 
> > Returning -EFAULT might break some user programs, I don't know.
> 
> As you mentioned above, other ->getsockopt() already returns -EFAULT, so
> what is breaking? :)
> 
> > 
> > I feel we are making the kernel slower just because we can.
> 
> Safety and correctness also matter.

Can you explain what is not correct?

Calling BPF_CGROUP_RUN_PROG_GETSOCKOPT with max_optlen=0 should not be
a problem I think? (the buffer simply won't be accessible to the bpf prog)


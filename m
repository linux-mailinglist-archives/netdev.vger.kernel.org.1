Return-Path: <netdev+bounces-148323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942619E11E4
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A52162576
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64F616DEA9;
	Tue,  3 Dec 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nXWE4q3t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4317BB1C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197131; cv=none; b=cZg/bKin+jKKdClWwriu/6lGnl4pagHSZHpoi+jTrQVZJW6rkRjFfoiQq17e6CWIYlws5HwU/xEjEIYqJatcDzfwd9frQ18afQr4US//YaLmAjkjrf1LZV/bZfRpsUSFoL2SaRzwrT5SJ3lcXiY3p0EOIuRQc9hykV3f/Sazm6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197131; c=relaxed/simple;
	bh=mQUjFYSbPJsdugtRaygePCyZNxgYO6OLr9YujVLTnyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEgBtCSw/0sxIvqNZ4OpQ3R+mtaUnNNX0HmyLVulwdCx7rEBYBvZkOSUXaAeH44Ou+drWAXvnYcKnga6Uwgki+vEq28gojMlRlo1qCF0bDc/3dyNnK+noSMcpeweNNM3Ew15xwf0QAT6jrZBnRrj2lq/fSj2+u3fZANGkdgTukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nXWE4q3t; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 015A440624
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 03:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733197120;
	bh=/1ELr/m1Bv2OGPjuOpiHnm1IVXq/mNpBWKXRMAF+/cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=nXWE4q3tQO5Gz/KTwjNa/WMFQZPCdTWLO59/oa0XfiE2CwEQ4l821FQyy+6e6Nw28
	 aaHI4FrCd9BSfv8Kw/JNe7oaqjCzzAmdnK16WA9b7CyvxGKnwpXhg8Dzcr7ST/TbJu
	 yIVCjueMpSccuxbvXnZLk2ghAUxYbeDfONOcW0O50FpgiYGi7I5IlxcvU7CVyTfRg+
	 MH+bC2d3SD+4HfQ2DyXL5A6Ns/NjuVSP8ciXbFCYUm4UIe9T/wq3K+2pW3mkUUNQZN
	 EOhbgNmEL7qF0ZlFcQ3teecyXPFesbR7ev0VJ9xckseg6G6VP+JhLmPLUM7kqNF+Ah
	 adjyyJNZAa4GA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-215a3fbb8d4so15556545ad.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 19:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733197118; x=1733801918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1ELr/m1Bv2OGPjuOpiHnm1IVXq/mNpBWKXRMAF+/cA=;
        b=BW8BY/8SqW/Q9T0a4jPwignkXec6+VQcY/usWCdtXDJTHd7TPBk3d91Tg8fNKWMts1
         u1vANeXOv/kKSJTKabf3cNSx1AInJePG3Gj07uVzDBMmCNlmSfHmXQv+b2gidTIrCO8G
         9vCA2s1fMeNDdaMSY8WV9jyUYoWK5E7qeH4u0gj4YxzhF227487rvCDprGreEvuwmiPe
         8ASNpuRN8sdHjNovbTHjQ5pFn6KHL6mvjbxCzNkA+JiyytcDYO8ks4Rr7Vhjh1pVu1rf
         y+L4Zw9f4IeMweSsl6+bjSjSmhuMz8lQ2XhrxXwYPKsO5SK7O515L7hgfhkVScbmPcmn
         9qcw==
X-Forwarded-Encrypted: i=1; AJvYcCU8z+R1qJKda4WNAWI2H95pDee31vDAn5tVKcXeUUbjZnMV/V90hn1p+5M+7mSann2NzQ1MM5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwafWeZPKKHRxZX8OAFLsGJKdVD9V16F1VhZLehnjcRfIIjhRe4
	q2ZVmy+iOrOcJgTCfulJGCtxKX+4AxzqFpEw5v0cGkMLadKMkdIiqfu/6kAh0SPTnPj3VsfYR+G
	MGCq1S23pjZd3VOIXiovZFfVcmC0mEmQPQGcIBR42JqZ/IJ8Pba6WZKyrSPW/iDTzFTZnsQ==
X-Gm-Gg: ASbGncshqH8r0r7EGTYjEHnOtQmVd7KfAK7/yAdCfYp0j3kNASpL7/KCRWkD56fbTls
	u0EMacGxlM8r/JPeMBqW3CILnt9N59ntXOiuI5C7Y2jxEspk2bazPkRVR+xMOFH7EZW/0rsOVOe
	1n1KN6KmqWjBD/KJa+atBPFSPTi/QGh9EykI2aciY6WojyjUHxP1P1b2APKjKtY5+Zc0F+5M3YD
	iRppZq1hwXrAoc1hSDpG3zGUPk5tPC8CDMC/HFLIstSAURQ1Z/J
X-Received: by 2002:a17:903:32c2:b0:215:5625:885b with SMTP id d9443c01a7336-215bd189d7cmr13412615ad.52.1733197118007;
        Mon, 02 Dec 2024 19:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiFXT/72acbiqUjNfZWjEnzEbxLtA1LUbxYQXxJZ1ukuWif4gI7XdthBZMTKX4TOQDY+6P+Q==
X-Received: by 2002:a17:903:32c2:b0:215:5625:885b with SMTP id d9443c01a7336-215bd189d7cmr13412525ad.52.1733197117737;
        Mon, 02 Dec 2024 19:38:37 -0800 (PST)
Received: from localhost ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905f4dsm84768005ad.78.2024.12.02.19.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:38:37 -0800 (PST)
Date: Tue, 3 Dec 2024 12:38:35 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
	mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: drop netdev_tx_reset_queue() from
 virtnet_enable_queue_pair()
Message-ID: <mwfore2i4ozfdue5ojq54o6bsjtr5y55eiemtwcl7ca6rb3hvi@k3kbcvrxw25l>
References: <20241130181744.3772632-1-koichiro.den@canonical.com>
 <CACGkMEtmH9ukthh+DGCP5cJDrR=o9ML_1tF8nfS-rFa+NrijdA@mail.gmail.com>
 <20241202181445.0da50076@kernel.org>
 <CACGkMEs=A3tJHf3sFFN++Fb+VL=7P9bWGCynDAVFjtOT-0bYFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs=A3tJHf3sFFN++Fb+VL=7P9bWGCynDAVFjtOT-0bYFQ@mail.gmail.com>

On Tue, Dec 03, 2024 at 10:25:14AM +0800, Jason Wang wrote:
> On Tue, Dec 3, 2024 at 10:14 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 2 Dec 2024 12:22:53 +0800 Jason Wang wrote:
> > > > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > > > Cc: <stable@vger.kernel.org> # v6.11+
> > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > I see Tx skb flush in:
> >
> > virtnet_freeze() -> remove_vq_common() -> free_unused_bufs() -> virtnet_sq_free_unused_buf()
> >
> > do we need to reset the BQL state in that case?
> 
> Yes, I think so. And I spot another path which is:
> 
> virtnet_tx_resize() -> virtqueue_resize() -> virtnet_sq_free_unused_buf().
> 
> > Rule of thumb is netdev_tx_reset_queue() should follow any flush
> > (IOW skb freeing not followed by netdev_tx_completed_queue()).
> >
> 
> Right.
> 
> Koichiro, I think this fixes the problem of open/stop but may break
> freeze/restore(). Let's fix that.
> 
> For resizing, it's a path that has been buggy since the introduction of BQL.
> 
> Thanks
> 

It makes sense, I'll send v2 soon. Thanks for the review.
-Koichiro Den


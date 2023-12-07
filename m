Return-Path: <netdev+bounces-54706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60631807E33
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 03:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367C828200B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 02:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B6215C9;
	Thu,  7 Dec 2023 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkxCEksM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21839D3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 18:08:21 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d06fffdb65so3224165ad.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 18:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701914900; x=1702519700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqe6+ODVrguz5c8m6TdqeAPB2/cG6oAt7NcdDHwUniU=;
        b=SkxCEksMNX1Wh9xoDpLf6tkvt+8ghD9/0SjHitfYinqGdZkx04Pc0uyiCfRTbpeB1v
         mjHcwgqbBq+LmZZ17LbeXp7g9+6W6QDoQt2ZCKDg11gi+1Itc+snurnobxqUxyRfN1ts
         pm9hX0OpppUsm5sPPfw1+rB3mD3t7113veFOIWzJJ1BTh2xd0hIQ6w6qlBqMCTaY0O51
         GBw+AJq+TN2s4Z1hiCutOtXaizRzVe3+NKLHAOhpb9R0KSCTctvExFmXmbxEBNr/Uxqi
         zqQbKsCAurOPTKVlzcY9C6oN+ctYW5aWdB0AzcC79h0Ohx/DYrVfgidw1LIHxjKRgFle
         HyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701914900; x=1702519700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqe6+ODVrguz5c8m6TdqeAPB2/cG6oAt7NcdDHwUniU=;
        b=JUs4FH5wRmxIAZ+HBARlb06fYOehNtDlwdqwckBA8Dn1I5kUNDKXrg3RmFERcXNHQW
         Cybgd75JNG2HXkiOI/ofP93nPwS/oBIQ1C9XD1/hr83JGpBytCy6QbQUwzC01wayTwpk
         QD28D9tDH2NB/KDib+A5SsR+wjU3CRgbFBbF22lNA30V0rtCBTmj/rxRckVYII5NrTQj
         q15IHgyeMeawT4EAg0ivKpMvhl0WkNiaWKzThWidIgmITiZP/TUMGXC6tnKSkJYROVz0
         fXEmbErcE7L11KOBHAbK9ByUZEIqS76qDoTspno3ESMDOLXH1bDEhYGOCah0qANzEjw9
         8Oqw==
X-Gm-Message-State: AOJu0YxEAyvaiNewZ5sMTvcwmkuw3BObrIAbjCvMdCEthvt1pyIb3mQJ
	1BX4SviEKUUjLgGtNZpqpHI=
X-Google-Smtp-Source: AGHT+IHPRst44H7aADvFNJUY3LQZsthl1oUhVIkM1K+oRkzR1qeJh9MJ4cy8hsX14yq/SLNbvhw17w==
X-Received: by 2002:a17:903:22d0:b0:1d0:6ffd:6e69 with SMTP id y16-20020a17090322d000b001d06ffd6e69mr1821150plg.97.1701914900387;
        Wed, 06 Dec 2023 18:08:20 -0800 (PST)
Received: from swarup-virtual-machine ([171.76.80.2])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902eec600b001d087d2c42fsm131764plb.24.2023.12.06.18.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 18:08:19 -0800 (PST)
Date: Thu, 7 Dec 2023 07:38:14 +0530
From: swarup <swarupkotikalapudi@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v5] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZXEpDtDkKMTQwmwy@swarup-virtual-machine>
References: <20231202123048.1059412-1-swarupkotikalapudi@gmail.com>
 <20231205191944.6738deb7@kernel.org>
 <ZXAoGhUnBFzQxD0f@nanopsycho>
 <20231206080611.4ba32142@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206080611.4ba32142@kernel.org>

On Wed, Dec 06, 2023 at 08:06:11AM -0800, Jakub Kicinski wrote:
> On Wed, 6 Dec 2023 08:51:54 +0100 Jiri Pirko wrote:
> > My "suggested-by" is probably fine as I suggested Swarup to make the patch :)
> 
> Ah, I didn't realize, sorry :) Just mine needs to go then.

Hi Jiri and Jakub,

Thanks for your patience and support.

I will send the new patchset tomorrow with Jiri comments fixed.

Thanks,
Swarup



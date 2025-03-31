Return-Path: <netdev+bounces-178420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4BCA76F89
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FE23AAE5E
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E480721B196;
	Mon, 31 Mar 2025 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An/ddUGh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E2121C175
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453712; cv=none; b=dG6TK4jQ58JrwHXc04wp36y7LJruIEYI7s6bc6O2Fq3zuhIsNS/FFCGn799c/Cr4IMcbCsyvnnAJQ2JC93lPzXowVg2DcFZ/GT8Qh92D8xd8pWCFzVNhI/2Yt6bnAajQVmqbCJnjcqdo91sAHEFxPhaOMQb5r9fTp/o036mQZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453712; c=relaxed/simple;
	bh=Cp5Oi8q/7evPMb1Qia5dEmEPtSvdkbJ2SZrQrBX/QS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAlaujjBfwH432T5AuMIPHbJWd0ZEP+1ecrMVpAeqOl9tc0rquH4sHgv5LZ2IX0Hi/Xgx+UyPCSWIqeurTKyhs6dfSIASxu3SEQFxjiM0XC1U0de1L7auwflebZ4McxFLzf8p9TwzvsSQiqq0/uKuPk8FbZsEtFnbxNNGEOeOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An/ddUGh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3015001f862so6318623a91.3
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743453710; x=1744058510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9kAwwpLNiKUHTLcKk9Qd4qLy+iBrpwMJWe0XZHYu6w=;
        b=An/ddUGh9qXP0DzDfLmYVEnyvW15neYMjJcbQYzb0/fhsilemI+vsGZ9Yclu+kz0Z9
         XrGDJZ8Yg5tDHsPSl5FejeuQcmWPmh71c97c2MGCnuyhHxy3sSCRShV5ZvTxF2yvFhrn
         QLcDdE49YPEabhCzwd7U71IemKfu4Icf1gn4cOz0JsqUxWOfGK/NOPdaGeGxGdgCtG/u
         o6gWwpHvO4Us+vBuerHCdxcwyRRfbo0b6wHiCDUwohwVCRGMMqO1EI289JxLUiqk4Kgc
         dVc9Y7dJMUOauPcEibmlC7oPRWdvxybPutM32dXoAweYddXIEhHqpZSEB/QNaD0ECKN6
         mBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743453710; x=1744058510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9kAwwpLNiKUHTLcKk9Qd4qLy+iBrpwMJWe0XZHYu6w=;
        b=dxVVFa73uDn3uWF3MCJ9s5cyPNEXnZMwa5t2W46z+NfzAqa7sWd8STWXa0HcsWtAyk
         hldCLZXIx8qzav4IiN29Ypy70ZCzkACbyiEsCbW1nS0ZDTx0nzNnSEZC3DYEa7L5Z1Sh
         mn/9VVSVrsbfaQqofw2aR6INd5mmOS34YaQF42p6robvsdE652tZ+I04ZREqHGB7EMsE
         R11F/KdM9MWNpGV3pW5hIS3ee3NJR5wrYosMXV0g/1SbQFJ6mSEDiNOgHYc/55r4DUYh
         nv5UAdqwAjNasPt8BcuZ5VCIV+TxCUFxMAKtZQQ5AmdkfF/I+GBxe85wu9qRvwdUjAIl
         MZow==
X-Forwarded-Encrypted: i=1; AJvYcCWVanvhVnWWcprOugAxTR3KHUY0EmYoHKalRgMPOXhY0AW94UFXIZA07YzifDKLFO1slw6yKVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxapMacGu9oYu0C3jKLAHoANcwxfIWLFlPv0jPg4cbotF/q1CKg
	3UwSUUbb8Lo/hmQLEv//3hbzyv9N0nbpNEJZZakv7epDYbmFQ2s=
X-Gm-Gg: ASbGncv/zxbeXIOW1nqCoB2B9Pz486kJt85YQmtAHBtlHTdLhaod5hJGp20xsk9PmV9
	VTZdwStddfv4n82LpXKQqWVlN7UaHAjz6SPTAXoIi7ofNZhC1m8lgRxBmlNeR0/qVkGtwvyeBMl
	BFpu6nQXr9xsgzqvsk/+kU9O1G2CEaHHDyR+MZipgBzl8s4XMq6bodee40gE1du2T8WRLFeeZpE
	9baJR8Z/N61QJCzWZwCngKiz5OdJ6UEqEGnLCXN4u7VnmOqbqpb39/zqwWVZqIbrH2IM5hiBbSF
	rlrc9QqqYVOZYzSW5uCeNH0KCwWpZleKcUaGuD4qqvGS
X-Google-Smtp-Source: AGHT+IGYm7ghD5Y/CcJ3Y/gZopBzJ+fahiyW6Du5JLzIXgEgxy/VsLBHIxFJn1aU+Azlz4nAl7gHNA==
X-Received: by 2002:a17:90b:574b:b0:2ff:7ad4:77af with SMTP id 98e67ed59e1d1-305320afafbmr14871249a91.20.1743453710459;
        Mon, 31 Mar 2025 13:41:50 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3039e10c545sm10106918a91.23.2025.03.31.13.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:41:50 -0700 (PDT)
Date: Mon, 31 Mar 2025 13:41:49 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	ap420073@gmail.com, asml.silence@gmail.com, almasrymina@google.com,
	dw@davidwei.uk, sdf@fomichev.me
Subject: Re: [PATCH net 2/2] net: avoid false positive warnings in
 __net_mp_close_rxq()
Message-ID: <Z-r-DYPvq7su9dkv@mini-arch>
References: <20250331194201.2026422-1-kuba@kernel.org>
 <20250331194308.2026940-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250331194308.2026940-1-kuba@kernel.org>

On 03/31, Jakub Kicinski wrote:
> Commit under Fixes solved the problem of spurious warnings when we
> uninstall an MP from a device while its down. The __net_mp_close_rxq()
> which is used by io_uring was not fixed. Move the fix over and reuse
> __net_mp_close_rxq() in the devmem path.
> 
> Fixes: a70f891e0fa0 ("net: devmem: do not WARN conditionally after netdev_rx_queue_restart()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>


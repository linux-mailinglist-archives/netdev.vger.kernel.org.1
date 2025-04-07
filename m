Return-Path: <netdev+bounces-179670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5152AA7E0DD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9D43A02FD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E581C84DA;
	Mon,  7 Apr 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+yFOOio"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F133195980;
	Mon,  7 Apr 2025 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035128; cv=none; b=HTHkR3DlpOTByMh/9Xf9l1QEKcwysURDRn8xl0YsIosgg8KUcPkw6mLwC/icJpW0zd79/97XszgzXbRsBosG8f0bPMPzNW094G/i7wpKRM9XT1Mj/cpUfr4oprgjNWZM0aomdSHyDmaArdO2R47PxB5rkznQ3kUO7Ufe1ibVVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035128; c=relaxed/simple;
	bh=BM5cV4bBXrRvHTbU7sz/LUIUOjziIRu1j9LSZS//g88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q237In4ex+1s8puVHg6jTcRqpfRZN9uyZxQePz12ehwiJZYcrdwlR0Q0lyzXvplLUuqP45oYPvIr75Lk7e8S0tJhOkBr4foOJzmcJa3ZbRZxhjBVSPVO39qlfcKSMRb+djBa+tgmJlb4gngBeENeFGD6FsI3TAhx8vO38Xzx3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+yFOOio; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af93cd64ef3so2860485a12.2;
        Mon, 07 Apr 2025 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744035126; x=1744639926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmtDaVACLlSu94GW/amGh9wB9MWFIy2Gxw81cDDDK4A=;
        b=X+yFOOiooRaYQm2sKTYKEIFMGo4WfAYY98jTrA+lkGEfPdy8Ky+fxKDK6LuvEYs4c+
         8/MXQGCCe+y+cT5ABp3ocdmzvGrAYm3pvqZH1uHAjxriu1jRKtR8v+aff0ESdIjhhur3
         /uoJ4Rw1LnfjCaPGXvC0AzAo4mwja1jj3tThmzw1YCIUTqwib9mnGdfjJgiLvI22ZS51
         CEa3wv+qazuH1CqIVX2oo4pWWVjb9olg73SpfkOtqoOVIBn4IRBLIPAi5bYUDbHniiro
         fFTHxeUINzW0WLBam5Ibgicr4xGgWpRokDXGXh4EnS32qJ6iFYZ9PpVuc0081JvMzTgs
         qWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744035126; x=1744639926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmtDaVACLlSu94GW/amGh9wB9MWFIy2Gxw81cDDDK4A=;
        b=MX3yTtevrESt+GCZP0O3guBUtoz8cTHAF3GsB/+aZG/w4HhOGGh+p6EndWkAT8CVMW
         tkqVKykOkyOwZzDwITJJSOAYGC8lNvDvvuCjT010qErRZ0q/lmRPlpcb+Pe0vnKSGYKo
         BLL7vGKrNDumjcRvhOXf6M3KUO3l1y9RhGuKKpWYwWq8UYR0aN3yYYTLpy6Lt3Y/mYT9
         pEbYOeeMVGoChtlLAN/Jn5wMGpP7VRrz1FUZtaJtUWzydQAiqpgGbLWHAocyVuCiKuqF
         PD9D7JfWq2IMinE3XkCI4UVlDHbH51Rw8iIcfhX1kQICvKY6Zv0rUCbYBcqu53mA9Brm
         vhhw==
X-Forwarded-Encrypted: i=1; AJvYcCVz+RNv6uSwMH/MexSUSBg9/gFqmALiHNJZCbeUz7+NaSNrI4w8KCgBkfCIa2ebdJ1s2cN7d72H@vger.kernel.org, AJvYcCXOa6/XdqbAlcDv9e/Mze36jH/aQFQ8tK/Gc4x4p2JMo1XyL4YQtZvcGEZqdv/KzPNDxDAIvk0wpykSPLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvrw++COZIiNy2oG5Nw05QvJXMtOwWu/YmXZcNwhbFrWxeHudg
	Svgc3p4VN4lEP+r2zto6A1XTT4oYO4Dp4G0MtU95peAFf6/iYHE=
X-Gm-Gg: ASbGncsJtSRt+o0t2UuTafEDJJ9OxlMbn1LA9JISNo5soKFUZ6kc916Wvq+8qlaGO/V
	TiIqHtEB8KWupVmYzBNvMN33TZLRBLNx5vp5Q1JH8+joi0p/zIIOde0tBx1eiPxTFJzMkoCsjiE
	bpBS5vr9KMX/nLKaNDxKlyCA3ep+isZ5aNYo2A4Zdn107dc3tqXpL/9K5P0L4XRvJQdu8zizhPf
	pwuQnFoneArsBS/YhwQRWKceADpoKbko8po8APcXDp8HZSodDc7OczvbjgqW82b5rilpMw0vWi9
	PYh6WF/DcxXGHUUuaTIDYWfwcgrtCg0Bhz+DekJOlBj1
X-Google-Smtp-Source: AGHT+IHvhv5UUYDWcqF+cM5R69UNg07/j0fxkjqP4eIQvIrI9zOpS3f8WzeG+b0JrqNCswA2NlRY1w==
X-Received: by 2002:a17:902:ef03:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-22a8a06cc5dmr160510185ad.27.1744035125271;
        Mon, 07 Apr 2025 07:12:05 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-229785ad9c3sm81324745ad.30.2025.04.07.07.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:12:04 -0700 (PDT)
Date: Mon, 7 Apr 2025 07:12:03 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+10d145ea96fc91185445@syzkaller.appspotmail.com,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, sdf@fomichev.me, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net: get ops lock under dev valid
Message-ID: <Z_PdMxDnE1j4sFks@mini-arch>
References: <67f36908.050a0220.0a13.027f.GAE@google.com>
 <tencent_ABAECE4C9727C606CDD2D6C67209852EC406@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_ABAECE4C9727C606CDD2D6C67209852EC406@qq.com>

On 04/07, Edward Adam Davis wrote:
> Make sure that dev is not NULL before locking ops. 
> 
> Fixes: 8965c160b8f7 ("net: use netif_disable_lro in ipv6_add_dev")
> Reported-by: syzbot+10d145ea96fc91185445@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

I think this happened first?
https://lore.kernel.org/netdev/Z_Pb9dku3R1wdTEp@mini-arch/T/#m733abfc2e974bf96cfdebc8a47aa58f39bf76b82


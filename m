Return-Path: <netdev+bounces-56120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9D180DE57
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473C41F2148C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AF15579F;
	Mon, 11 Dec 2023 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl79AuKH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ED5AD;
	Mon, 11 Dec 2023 14:34:35 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d7346442d4so48469777b3.2;
        Mon, 11 Dec 2023 14:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702334074; x=1702938874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=weETpER/W9eWKpDs0aTzW8/kqujO5Ns20F+TiP+lNxc=;
        b=Pl79AuKHMkBMVGDU1JhLlZWOW82hDx+5kpah8WvIfmhdo3NFuiBWyiTL4jHiJ+vw3Y
         FD+a5CS0d/gsGgkN/H85162od3MZJM9TjNwgNiOFxN817dCnCtm4IrCcxIWcDYAtbbo4
         1446I//YBfT6gMBKLfZXnLtY33YDdLUg1vrKoUXr3E7OtpOpkCu25VlVO9ZzgQ2vNrpB
         R+4cnnTMzwEFLdOzgH2Zvr8fJBN7gtXPaPoAeklKOt3s4iKdw0fkU4WjOKA562qk5MHx
         UrGZZWbGE1Hpta5GDVnoav1GSnRKn8yvdUhiggFBgeeEWE+Lv4W9tM6nhn6G3vYydW7/
         ZH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334074; x=1702938874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weETpER/W9eWKpDs0aTzW8/kqujO5Ns20F+TiP+lNxc=;
        b=J6vcHbs2TcXDlP88yz0kttxNPvJEYz581ya0CxBzw/9XBol4i2Db6XqLAGg6tnqBYS
         7k9r2B7QFiI2yl4ydw/t1CYnkycDpf/H0X1QsdW9dc0nfyfU3LvWXybiffL5GUg7Sm3R
         wP0oJfQnoffWQHZI9WtysE927RjBiqyz/wATIM73I9dbnLXn3H59h11JSUOtQy2npjIK
         Ye9SECjAeqXrkDAu1BRqw9Dj6vOglrXkuW8XZBXFxt6jlzrQC4e+NcgdTKPGyccz9EvV
         7rzv7PXh8q+57GHKxO51YGgNiubnN7Vn+hAdGy5BcTAiWpQZDhHt71KfsTh8A6da5ULP
         tFHw==
X-Gm-Message-State: AOJu0Yx1PQJgu6sqGdNkJgnUL0JnZ0p56IEEu76A3jNCsm0MoiI2FiBu
	cRCmZFYesBogcbybC6u/aDs=
X-Google-Smtp-Source: AGHT+IFimdgWnRBEGiupflIWc8T6D9ybHk5AtdinAtNWHe5eWoKDkGhnHAT7dqZcZW2Yc4O6uagmwQ==
X-Received: by 2002:a0d:d994:0:b0:5d7:1941:3576 with SMTP id b142-20020a0dd994000000b005d719413576mr3132315ywe.93.1702334074480;
        Mon, 11 Dec 2023 14:34:34 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id e3-20020a0dc203000000b005c5a08c5c15sm3297708ywd.136.2023.12.11.14.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:34:33 -0800 (PST)
Date: Mon, 11 Dec 2023 14:34:33 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v2 31/35] net: smc: use find_and_set_bit() in
 smc_wr_tx_get_free_slot_index()
Message-ID: <ZXeOef/60Crhrm2Y@yury-ThinkPad>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-30-yury.norov@gmail.com>
 <b344c321-b481-48b0-8165-c3ab604fc397@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b344c321-b481-48b0-8165-c3ab604fc397@linux.ibm.com>

On Mon, Dec 04, 2023 at 10:40:20AM +0100, Alexandra Winter wrote:
> 
> 
> On 03.12.23 20:33, Yury Norov wrote:
> > The function opencodes find_and_set_bit() with a for_each() loop. Use
> > it, and make the whole function a simple almost one-liner.
> > 
> > While here, drop explicit initialization of *idx, because it's already
> > initialized by the caller in case of ENOLINK, or set properly with
> > ->wr_tx_mask, if nothing is found, in case of EBUSY.
> > 
> > CC: Tony Lu <tonylu@linux.alibaba.com>
> > CC: Alexandra Winter <wintera@linux.ibm.com>
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> 
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> 
> 
> Thanks a lot for the great helper function!
> I guess the top-level maintainers will figure out, how this series best finds its way upstream.

Thanks, Alexandra. :)

People in this thread say just pick their subsystem patch together
with #1. So, I'm going to send v3 with some minor tweaks, and if
everything is OK, will pull all this in my bitmap-for-next branch.

Thanks,
Yury


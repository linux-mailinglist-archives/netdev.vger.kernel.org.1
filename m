Return-Path: <netdev+bounces-127969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478F9773F2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516B21C23DA3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE43A1C2438;
	Thu, 12 Sep 2024 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amDSnNwm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682DB481C0
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726178258; cv=none; b=eNHh+tFAkhoX1uHBKK0w4ddyQ7vYtcdZAsASTcbG2MzXKpMbNXnwE0TxLfBCx8jWL9iXGdwvn454/275dmj3ud13pZX0W1CM7FWTsBr7OSDsYVwR1qcRWipE8gmikzGFMpr68O9LkKUeRLv1pm/DsQ32UkalSvLDghyGnUD0uME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726178258; c=relaxed/simple;
	bh=DHA7aGHrrDjsXExPCJW8HMyT2cxNlD5YrcHB25vvjVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZLcsKmGCSlmA3CQIkGOV6vjo8fc+Lp3nR10I/2JiXvLFsonieDd+jXLz8dPgU79afV8TcHg7diK5n7dxZeRvMymPIinsn5hHlS5/EGl79kMiERE3cTmJJ3FqIz1kfMew0UAYyah1RwM6SfDfjLiUaRqoKvuG+nNwe8jR17FqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amDSnNwm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso987682a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726178257; x=1726783057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TLhUQ/v891i4536XrgyhyFrAEt1rrhz9sc1OhRAk/I=;
        b=amDSnNwmYs0gfc9KVQ3BbvmSJ1GX3SLyz8NyRpDGS+eXb+9VXRc8zO6+MsT6jilx06
         EjuC1d51HQsVwoNNp8+Wzw03NuW3Zq4GgABoaQBO4KmE5o3p2zh+gZwfkaxG3z5DecQQ
         evnUkbMKQdv1alOqthAsuIuzQFbyxg8aoAkx7ZIBV8XFsR7J/Nsz0Iud0AfvmGVAux79
         7nuVV8YzDinM1RWTUZWcfTBnr0C8mMe97fY9eMcmVYbUy9tlCo8DMeGf8e2Pjnoonjy3
         TE+S0+4Y+CFoajc6Rx2luR5TyfM6Z+8Bp+Wve+SUrdFn6sG8QWrgXmCiE+AMT0Zxgece
         H3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726178257; x=1726783057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TLhUQ/v891i4536XrgyhyFrAEt1rrhz9sc1OhRAk/I=;
        b=d8aY74n2RYyOIsQomgLtdhrwkogfsoSDaig/fB7HgeGr1R8PFrmUVImXsVeptJkYPw
         QBBh+dCzQe8MgdHNPsXqVvB6UatvQhpYefxFvW97glU8CiPXT1Zbcc+P5iYkrClhqIDF
         jd3nFWJQBEnV1rvhH5lFyFLaXaMq/JpbaJBW0Sznin+dWCX7wrGVOpjjFtr/bYRmUGE5
         yrR0udMZ4Msk5PUFUqJEQf2EmR3pClLlu3VOONm4IhdFVM4OPIcR01GVqhM8VLp2vUh/
         ASZbf9obmVN6p/5hKeBOplmCKnUw8vwdZgIeSnE6QgqsUQFWV/sojZELpPnQEc9Uf37N
         +Fyg==
X-Forwarded-Encrypted: i=1; AJvYcCUpBiNCDII+Tlt/oUc1A5i6IAsJD3tBSf4ijQMVPfBaRRgXFrhNj1xkSbRvb7ix3Yhye0mPgmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1M/kpSlwbf629ihPeJ7toQpxuqNRRtVQ0HvWVafS8D99Rmrm
	+qZ0IBF0DTaOcwfgNQICUztMtfucdrLik4NPlH2s1AzfkrfEQBg=
X-Google-Smtp-Source: AGHT+IFVOe51NZ438TwXlN9QP8IeGKpPsqdvgqnsBsML0B6weeuh16PsOp+7ROJNhTnjVwSAiEsTPA==
X-Received: by 2002:a05:6a21:710a:b0:1cf:2fe2:a74c with SMTP id adf61e73a8af0-1cf761e58camr5333950637.31.1726178256609;
        Thu, 12 Sep 2024 14:57:36 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fdf636dsm2215336a12.83.2024.09.12.14.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:57:36 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:57:35 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 02/13] selftests: ncdevmem: Remove validation
Message-ID: <ZuNjz7HvlD4z6dR8@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
 <20240912171251.937743-3-sdf@fomichev.me>
 <CAHS8izNOZMeNi4WNWL9jmLd-rJeGA=M3zBKDSzMNHZ3sZOxUuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNOZMeNi4WNWL9jmLd-rJeGA=M3zBKDSzMNHZ3sZOxUuA@mail.gmail.com>

On 09/12, Mina Almasry wrote:
> On Thu, Sep 12, 2024 at 10:12 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > ncdevmem should (see next patches) print the payload on the stdout.
> > The validation can and should be done by the callers:
> >
> > $ ncdevmem -l ... > file
> > $ sha256sum file
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 56 +++-----------------------
> >  1 file changed, 6 insertions(+), 50 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index 352dba211fb0..3712296d997b 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -64,24 +64,13 @@
> >  static char *server_ip = "192.168.1.4";
> >  static char *client_ip = "192.168.1.2";
> >  static char *port = "5201";
> > -static size_t do_validation;
> >  static int start_queue = 8;
> >  static int num_queues = 8;
> >  static char *ifname = "eth1";
> >  static unsigned int ifindex;
> >  static unsigned int dmabuf_id;
> >
> > -void print_bytes(void *ptr, size_t size)
> > -{
> > -       unsigned char *p = ptr;
> > -       int i;
> > -
> > -       for (i = 0; i < size; i++)
> > -               printf("%02hhX ", p[i]);
> > -       printf("\n");
> > -}
> > -
> > -void print_nonzero_bytes(void *ptr, size_t size)
> > +static void print_nonzero_bytes(void *ptr, size_t size)
> >  {
> >         unsigned char *p = ptr;
> >         unsigned int i;
> > @@ -91,30 +80,6 @@ void print_nonzero_bytes(void *ptr, size_t size)
> >         printf("\n");
> >  }
> >
> > -void validate_buffer(void *line, size_t size)
> > -{
> > -       static unsigned char seed = 1;
> > -       unsigned char *ptr = line;
> > -       int errors = 0;
> > -       size_t i;
> > -
> > -       for (i = 0; i < size; i++) {
> > -               if (ptr[i] != seed) {
> > -                       fprintf(stderr,
> > -                               "Failed validation: expected=%u, actual=%u, index=%lu\n",
> > -                               seed, ptr[i], i);
> > -                       errors++;
> 
> FWIW the index at where the validation started to fail often gives
> critical clues about where the bug is, along with this line, which I'm
> glad is not removed:
> 
> printf("received frag_page=%llu, in_page_offset=%llu,
> frag_offset=%llu, frag_size=%u, token=%u, total_received=%lu,
> dmabuf_id=%u\n",
> 
> I think we can ensure that what is doing the validation above ncdevmem
> prints enough context about the error. Although, just to understand
> your thinking a bit, why not have this binary do the validation
> itself?

Right, the debugging stuff will still be there to track the offending
part. And the caller can print out the idx of data where the validation
failed.

The reason I removed it from the tool is to be able to do the validation
with regular nc on the other side. I just do:

- echo "expected payload" | nc ..
- ncdevmem -s .. > expected_payload.txt
- [ "expected payload" != $(cat expected_payload.txt) ] && fail

If I were to use the validation on the ncdevmem side, I'd need to bother
with generating the payload that it expects which seems like
an unnecessary complication? For the (to be posted) txrx test I basically
do the following (sha256sum to validate a bunch of random bytes):

def check_txrx(cfg) -> None:
    cfg.require_v6()
    require_devmem(cfg)

    cmd(f"cat /dev/urandom | tr -dc '[:print:]' | head -c 1M > random_file.txt", host=cfg.remote, shell=True)
    want_sha = cmd(f"sha256sum random_file.txt", host=cfg.remote, shell=True).stdout.strip()

    port = rand_port()
    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port} | tee random_file.txt | sha256sum -"

    pwd = cmd(f"pwd").stdout.strip()
    with bkg(listen_cmd, exit_wait=True) as nc:
        wait_port_listen(port)
        cmd(f"cat random_file.txt | {pwd}/ncdevmem -f {cfg.ifname} -s {cfg.v6} -p {port}", host=cfg.remote, shell=True)

    ksft_eq(nc.stdout.strip().split(" ")[0], want_sha.split(" ")[0])


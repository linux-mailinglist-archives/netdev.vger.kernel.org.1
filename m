Return-Path: <netdev+bounces-127950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BDB9772C8
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 22:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6201F242B7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EAE1BF80E;
	Thu, 12 Sep 2024 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USf6Gddm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91A1BC09F
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173403; cv=none; b=QrSvUxOr3CHJrneqD7v0yl1BReQuC3OBCcQLFvkPN9ayCLrRik7/y+DD3LgGAHKdgFj2REJz+F6rtb7zvxaqCO8HN9bAp62zvB6WsAPU3veXo4G/W7f+ErsQyN8jqqYCrVeIDECTa4WgAOm9lmDh9N8b9Sy3dfmrDKGEgs9YW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173403; c=relaxed/simple;
	bh=OBQ3uHC6peS6VrzbsfRbzQobSqLMB9C+kvfjMGjZgYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIs7s7rrfKt/kc1pshAIcijk0KRBS87S8qD0AILVGw8XgElsQ4XrahMir6WrDKa/Brfxjg+lS6LDUwS5g2k4mJQifcByVvIl7idEHs8GH2E8oEFY0d46u/pMRK5eE97eJ4LliaWplHcrvJSMwVIBBVx7W16FuvD4o7+rKRtdX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USf6Gddm; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4582fa01090so75851cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173400; x=1726778200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVKOCRwl1yeZB/D5R7kP7P4UGf84CQdu3Y5U5Kbjuc8=;
        b=USf6GddmUiKf8bo7D666G40fJFJjR0ssnyRViQ/JItU1rylbF+YkG8fN7I3gswJyXE
         dtKP74K8ZtCcFdzSmd4eEzYE+ZeCgLWigykI7lpSkIFukbsrdGooA3PDXeZMyeQK1QZO
         j0bH1bp+qG4OiZykaONIDTeyEr5Fc4ocxhn7xCd9wWkW3iEP4FQrkqFwzF5e/QyuUOmr
         ZAFE+VXG/g+k7jb2Wftjx0xe4oLeyf4wEJ7sSvqupXBomDJPo2tNtclJIxl4diSvZCdd
         W2A0ouWo3NN/EIIMz9bZ6iPOJOQeIuobT93OoSdpvGfkJiAu133m77FFeZOBQkiUM49Q
         3drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173400; x=1726778200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVKOCRwl1yeZB/D5R7kP7P4UGf84CQdu3Y5U5Kbjuc8=;
        b=cbOAo3bqzGmUCzFXm+GmVCaz/2XsK6YaRzfU29CEwDs+xi0Tvy5mAkcvGIaAZi+uUH
         5ZJBYqL9j/JUuXPZGmihu86plp/zzR1wtw6xVi5p/9qKnsde3qRCs9Do2sFd85jKyZli
         0uUDwO0RRBJGlUfo+cNcf1CZ2HPrvBBhKjAXfOU+JRKrRwqaCD9i4/MUhpmxCBeRFRyn
         txJztUgQO5NDxxwK8E9zujPAf5GfhsHLpITF5xWPYqSRNckajPli8js5ZFnuaKoYKfTW
         KrVJCYwEP3MkapZeJLBcgG2pfExlDt+WDazciIUWiw5JfSXvE+EpGxMED+BeRC7fcSsM
         ttbQ==
X-Gm-Message-State: AOJu0YxuYtx6+a1XATVeMpVhTN5Nxv5MG4y4fPx89/elOKH6/6QP4y/m
	PfJXPTpy0z9WupDaEyoF9io12jvwZSejRaryycR4Lr/6sJ8kboBwFsD356pGjmt1B+FdAUnLwxz
	7MEv1kMplpU5zuKtc0Z63qPg+5+Ka+nq4A5qS
X-Google-Smtp-Source: AGHT+IFos3rYiEe4EjnVn+fu0cozaHGhghQGyh2dXrJ0xoeoYr7YScSqTCZhXVmChsYFAYktlPm8VKgrPWQAb/jmqI4=
X-Received: by 2002:a05:622a:87:b0:456:7f71:ca78 with SMTP id
 d75a77b69052e-4586079bbd3mr4832951cf.4.1726173400242; Thu, 12 Sep 2024
 13:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <20240912171251.937743-3-sdf@fomichev.me>
In-Reply-To: <20240912171251.937743-3-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 13:36:28 -0700
Message-ID: <CAHS8izNOZMeNi4WNWL9jmLd-rJeGA=M3zBKDSzMNHZ3sZOxUuA@mail.gmail.com>
Subject: Re: [PATCH net-next 02/13] selftests: ncdevmem: Remove validation
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:12=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> ncdevmem should (see next patches) print the payload on the stdout.
> The validation can and should be done by the callers:
>
> $ ncdevmem -l ... > file
> $ sha256sum file
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 56 +++-----------------------
>  1 file changed, 6 insertions(+), 50 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index 352dba211fb0..3712296d997b 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -64,24 +64,13 @@
>  static char *server_ip =3D "192.168.1.4";
>  static char *client_ip =3D "192.168.1.2";
>  static char *port =3D "5201";
> -static size_t do_validation;
>  static int start_queue =3D 8;
>  static int num_queues =3D 8;
>  static char *ifname =3D "eth1";
>  static unsigned int ifindex;
>  static unsigned int dmabuf_id;
>
> -void print_bytes(void *ptr, size_t size)
> -{
> -       unsigned char *p =3D ptr;
> -       int i;
> -
> -       for (i =3D 0; i < size; i++)
> -               printf("%02hhX ", p[i]);
> -       printf("\n");
> -}
> -
> -void print_nonzero_bytes(void *ptr, size_t size)
> +static void print_nonzero_bytes(void *ptr, size_t size)
>  {
>         unsigned char *p =3D ptr;
>         unsigned int i;
> @@ -91,30 +80,6 @@ void print_nonzero_bytes(void *ptr, size_t size)
>         printf("\n");
>  }
>
> -void validate_buffer(void *line, size_t size)
> -{
> -       static unsigned char seed =3D 1;
> -       unsigned char *ptr =3D line;
> -       int errors =3D 0;
> -       size_t i;
> -
> -       for (i =3D 0; i < size; i++) {
> -               if (ptr[i] !=3D seed) {
> -                       fprintf(stderr,
> -                               "Failed validation: expected=3D%u, actual=
=3D%u, index=3D%lu\n",
> -                               seed, ptr[i], i);
> -                       errors++;

FWIW the index at where the validation started to fail often gives
critical clues about where the bug is, along with this line, which I'm
glad is not removed:

printf("received frag_page=3D%llu, in_page_offset=3D%llu,
frag_offset=3D%llu, frag_size=3D%u, token=3D%u, total_received=3D%lu,
dmabuf_id=3D%u\n",

I think we can ensure that what is doing the validation above ncdevmem
prints enough context about the error. Although, just to understand
your thinking a bit, why not have this binary do the validation
itself?

--
Thanks,
Mina


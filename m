Return-Path: <netdev+bounces-134890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608BB99B82A
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 05:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC14282AFF
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 03:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B685C5E;
	Sun, 13 Oct 2024 03:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNwORDXV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A641C62
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728791443; cv=none; b=kiu9Wxds+YWGYl/l5tA/6UpZOFvdStxK4P8vDMYcqa1sXB7DIYGFusdU5WWg+gBrdpByWSOXusseW6HGgArKYLELWFPchb6WYTdcpR/yWmxE063AtWecJpmt+PkHnx6KLiPsUO3n+D4QT0pDl4vrCxl3YqfAUkDmv7dp7dJ5dYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728791443; c=relaxed/simple;
	bh=Gx9c17BzNe1igyaanB1st2zpeVFv7yuuVKO90GgBXgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBrJhUCgj7z2ecMVNzWeDL3pMBUq2hS7pmvF/lCp7sC2PwUZoUhv//Ku09bX69HG5UAWlCshMddCqZNZza+obTTg5BxRHQ9DiyVB5E5fC9zX+6IxvoARxLOWG6kXndQgWD26fUCY+T4fILSBuExJveeuNps+XD8eeb9Z+FxmesU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNwORDXV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460395fb1acso210331cf.0
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 20:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728791439; x=1729396239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uj/Ot3s3RhiNVKmKSAZciL8dG1uUgzt7G940lmNkhdE=;
        b=mNwORDXV8yBg9ZK34ytrg0mxxIKchsarMVobwO0ubFyjrivDzdl0rUnZhfeVu4RpQQ
         Xn0N+bpbHwnrWn8M1INifRNM2T90jLILCfP/Q7MwH/R2U053KsGt2ruy3GjObBxTObiL
         79/k11fsrCHvHVkTkB8IgD5EjSOHsWsvxiFZVbiCF/CJu30ljO3He3zzPTBACrqawE3X
         SPYhfKl/QdqzYksFsL+yOGv/kjj2hcJvovQJaQQ3s9ZNELo8jptV8QpXtg8xrSX3FH4W
         ITqvpH+JnJ5rSs9sKgU31uXwIVQ8NKhHtFER2WsQM8EyjucROPUD9cax00yvROSmY2gs
         w5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728791439; x=1729396239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uj/Ot3s3RhiNVKmKSAZciL8dG1uUgzt7G940lmNkhdE=;
        b=itldXdjO/P+E7cUnIhJd7s0TRc0H8I0uWk7INb1fG7Ob9qFnEHMuBwy8e9S7KkWXmc
         fLVoI144R9u8dwZ4CPAo557e1DpAvgVtX8Oo6DrBRsYLeQso0+Tn4C/7FGqtGLiQspWk
         7rU53v8ZAa/Qn7tjk9r1HLDpnF0gNsfhkK/WFKvZrAwDREskkYpoBaREryJbRSUNgzDL
         La9IJg7x3e6Xj+IAOV8KCRZcbo9adDHYF7qZdyeYI8PFXvLg0SjsTasMeIZAX3NZ9Uze
         ocNnVmJpqi3ZNJYTNogMaAM/cOlahmcxZptq2kxJcpHvRqBdMZljScB6paP6svcdrk1Q
         02yw==
X-Gm-Message-State: AOJu0YzW7AHJZbKGxlXC9WcOqq+BVe0+2dIEzbp1ECEMnDldGelshB0F
	xphGZWdmpdMncoH9G85RY0Icv//I4tj7cparZ9g8Itm1sgbaf+4v+H014QhIqLiXJNB2611ot3Y
	BmcPxlNuBHT7gDZ95hSYDPCsxhslsRktI5V85
X-Google-Smtp-Source: AGHT+IF1f6UO64RLmGCRt14BoTwJKj0ktXj/s7Hv5LWI/crlu1yTGcgHUoS9tp8Zh60rfAWZ4xdvrIBCwVhkaVjARzM=
X-Received: by 2002:a05:622a:47cc:b0:460:49fd:6db0 with SMTP id
 d75a77b69052e-46059c78a76mr2030681cf.29.1728791438982; Sat, 12 Oct 2024
 20:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009171252.2328284-1-sdf@fomichev.me> <20241009171252.2328284-10-sdf@fomichev.me>
In-Reply-To: <20241009171252.2328284-10-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 12 Oct 2024 20:50:25 -0700
Message-ID: <CAHS8izPh7kwnvQtxwqGxka_rOe0fB21R7B167j2guJXkve9_bg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 09/12] selftests: ncdevmem: Remove hard-coded
 queue numbers
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 10:13=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Use single last queue of the device and probe it dynamically.
>

Sorry I thought agreed that multi-queue binding test coverage is important.

Can you please leave the default of num_queues to be 8 queues, or
rxq_num / 2? You can override num_queues to 1 in your test invocations
if you want. I would like by default an unaware tester that doesn't
set num_queues explicitly to get multi-queue test coverage.
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 40 ++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index 02ba3f368888..90aacfb3433f 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -63,8 +63,8 @@ static char *server_ip;
>  static char *client_ip;
>  static char *port;
>  static size_t do_validation;
> -static int start_queue =3D 8;
> -static int num_queues =3D 8;
> +static int start_queue =3D -1;
> +static int num_queues =3D 1;
>  static char *ifname;
>  static unsigned int ifindex;
>  static unsigned int dmabuf_id;
> @@ -196,6 +196,33 @@ void validate_buffer(void *line, size_t size)
>         fprintf(stdout, "Validated buffer\n");
>  }
>
> +static int rxq_num(int ifindex)
> +{
> +       struct ethtool_channels_get_req *req;
> +       struct ethtool_channels_get_rsp *rsp;
> +       struct ynl_error yerr;
> +       struct ynl_sock *ys;
> +       int num =3D -1;
> +
> +       ys =3D ynl_sock_create(&ynl_ethtool_family, &yerr);
> +       if (!ys) {
> +               fprintf(stderr, "YNL: %s\n", yerr.msg);
> +               return -1;
> +       }
> +
> +       req =3D ethtool_channels_get_req_alloc();
> +       ethtool_channels_get_req_set_header_dev_index(req, ifindex);
> +       rsp =3D ethtool_channels_get(ys, req);
> +       if (rsp)
> +               num =3D rsp->rx_count + rsp->combined_count;
> +       ethtool_channels_get_req_free(req);
> +       ethtool_channels_get_rsp_free(rsp);
> +
> +       ynl_sock_destroy(ys);
> +
> +       return num;
> +}
> +
>  #define run_command(cmd, ...)                                           =
\
>         ({                                                              \
>                 char command[256];                                      \
> @@ -690,6 +717,15 @@ int main(int argc, char *argv[])
>
>         ifindex =3D if_nametoindex(ifname);
>
> +       if (start_queue < 0) {
> +               start_queue =3D rxq_num(ifindex) - 1;
> +
> +               if (start_queue < 0)
> +                       error(1, 0, "couldn't detect number of queues\n")=
;
> +
> +               fprintf(stderr, "using queues %d..%d\n", start_queue, sta=
rt_queue + num_queues);
> +       }
> +
>         for (; optind < argc; optind++)
>                 fprintf(stderr, "extra arguments: %s\n", argv[optind]);
>
> --
> 2.47.0
>


--
Thanks,
Mina


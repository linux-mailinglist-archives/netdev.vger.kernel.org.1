Return-Path: <netdev+bounces-14982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A22744C8C
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 09:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C76D1C208EC
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254E17C9;
	Sun,  2 Jul 2023 07:51:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669917C7
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 07:51:07 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9210E7
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 00:51:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-263036d54b9so2393279a91.0
        for <netdev@vger.kernel.org>; Sun, 02 Jul 2023 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688284265; x=1690876265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RD1AHeV1SJQ3uPTC/rrtRPO2tWOTjqWX/W+UKHi4DlY=;
        b=cqx5HqwqBin+wcFKtE1M6H13NwW+7Gfdj4tzQmrNQvb1w1iLUMrLTNPfl5jpeejVnt
         xt2BP73lE6yldnsXPjOYZ+QF7awCdYI4c1UIj+hZ7Ekt4AhXhgzfVeqeNyZXdZOLflfv
         G1Fx7tE+ZOaQ7kWynDLTLYWLolbqRSbtjmSMAWkZIiWYMP33Mg2BJIH4vn7emaXxQwIb
         M1xSZ3zzjdjPVnQBJ2C0YHdlzJCKOgH+02Fwf68pzLQJArjfeuHmaO+oc3sXKKzpku8w
         n3vmIi7/E9PgDki8ydBhlxJv7lJLVnQ+F1wjg43gsn+q1L5z7ouLzOc6Cecap4QWTx8K
         D2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688284265; x=1690876265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RD1AHeV1SJQ3uPTC/rrtRPO2tWOTjqWX/W+UKHi4DlY=;
        b=XCOtD69Ma8Av3jJ9FqbuRfux+yL812KtI46cnpkk/ZxXLfCQ+TSxNv3Ryj4LEYefnb
         IK0YciJl3KC8YmWRr/EmEsmd0dXAw0kza0Tx9qvn6pCobLvs4ucOXO2PdMw7Ig5JHQRU
         Gfw+ogARMBCxdf/l/ErT7CSvvE6wR/a2sdkvOccJhc7hrI1NmJnRI4lCm59KtJDHT744
         fHpApSZU9A9MTWB6WujweRCc6kJvLzjNEGeP3gEqZcisL+54wKONxZXYy4XeGEEU0oIf
         wefP8Yj7ZDSuGUnwR2VWUBmpQRtzv3qLHj9YCERFLRbItiLImQbqmd2gnrGqUHc2p66m
         dF1w==
X-Gm-Message-State: ABy/qLaNUyyl74mRCj9dgxMHtu/m+U2o3pA5Ib7gGQKvzMXQTi7jx65S
	dLmXILCCPUzsAitawySXaw9AmfjEVWNPJtMNqbcC
X-Google-Smtp-Source: APBJJlEhF/ip+GhDkYiwrUANCxYVx/LQKbYNlJmYerg2qXgEwMMAyjBDen3rf1/bhM27dSAtjXSd6e3tiZFTsEzQOqE=
X-Received: by 2002:a17:90b:3105:b0:262:e598:6046 with SMTP id
 gc5-20020a17090b310500b00262e5986046mr7984826pjb.28.1688284265107; Sun, 02
 Jul 2023 00:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com> <20230627113652.65283-3-maxime.coquelin@redhat.com>
In-Reply-To: <20230627113652.65283-3-maxime.coquelin@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Sun, 2 Jul 2023 15:50:54 +0800
Message-ID: <CACycT3vgtP8sjoZ2BQC=Y1Vrj1yBczaeas2z0uEGan5BAHm54Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] vduse: enable Virtio-net device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Marchand <david.marchand@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	virtualization <virtualization@lists.linux-foundation.org>, Netdev <netdev@vger.kernel.org>, 
	xuanzhuo@linux.alibaba.com, Eugenio Perez Martin <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 7:37=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch adds Virtio-net device type to the supported
> devices types. Initialization fails if the device does
> not support VIRTIO_F_VERSION_1 feature, in order to
> guarantee the configuration space is read-only.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji


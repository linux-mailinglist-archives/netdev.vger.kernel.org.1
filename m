Return-Path: <netdev+bounces-39695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91F7C417B
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3861C20CC8
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88596D309;
	Tue, 10 Oct 2023 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsvKdHW8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BFE315A7;
	Tue, 10 Oct 2023 20:41:22 +0000 (UTC)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF0BD8;
	Tue, 10 Oct 2023 13:41:19 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4527d65354bso2534150137.0;
        Tue, 10 Oct 2023 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696970479; x=1697575279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTF6MCoYDoeUf+zV7URO5R9YigP5bU5Jr4VwKHYzrPk=;
        b=TsvKdHW8iwWbkSlnuvcos3CanTbHRoybtAjfVRgLW0ti+IvXYSLK2tmgcYz+/cgdVo
         SNGLKJ9m61uHJiIyn+rcMcr/KyXSUSyxyDqOntHKyy3KjFZsz8TwH4+9Wb2W3tbQXRB3
         YjhdL8RAEA626r9om9O6txbWkBdcORhcmFkjiCAYS2VLbRCoGl1iuT3Er1YHJrPKj7OQ
         pvof19i90S2qQC12SQcoAivEIxPPgqk+p3vzN9iBg8haUa6/LqN8/ohf9EDiENPpLlHz
         hkYRea/+c/wfeCJu6HEGfHjqorn9jWefA3okbKLLalFCkMHOIMvkSaq6DSTkSAJCU74P
         piJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970479; x=1697575279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTF6MCoYDoeUf+zV7URO5R9YigP5bU5Jr4VwKHYzrPk=;
        b=EMOj9KwKyyLKtNYbQ92zPEjmpACImi/LOyCIRVdUsbSS4YkAtXxBE0UjEPK05YQNvH
         Vi7BmaVtyy+GC6JuNHxHh6noWunvZlN1v6KYWPQwXgqaUFYzYfwnv52IvG19JowLbc/b
         2EW/O0H7QOOXpJRFluwiuXiZD72jvB4/a3mVHn7Bnv30aRE/fIxOBDOS+VG0snjf3Vmv
         z0SAU1q4gzN8FnJvZxYL4OX66WXIPSk5NvnkmAq6ZsjsRmADcJzTSpGoZjaUa9uGllfR
         aIvqNqQnLYheinUYvsY910+6OrfLZ5p3PR3Fh39wX4aLBlJ1Wg3x+C5cO+UT4/eSfEk7
         n7LQ==
X-Gm-Message-State: AOJu0YxbGyTn3mmCCQ4vKs33uVFh3AfSI6a9HxWlHAY9n1QgCNkGAeTN
	PXTjFVmMtyWmWSWkwNduvtHV3g0jMLQyf4NggDY=
X-Google-Smtp-Source: AGHT+IH7+jO+GducYPOm5h1Hr2zXIUuhTzMulpkrAYoct2e/rNppCwjjo91sw9oj9ZDZLcJCNwydeSmPJbML/qoiV9A=
X-Received: by 2002:a05:6102:3169:b0:44d:48bf:591c with SMTP id
 l9-20020a056102316900b0044d48bf591cmr16921661vsm.30.1696970478566; Tue, 10
 Oct 2023 13:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010200437.9794-1-ahmed.zaki@intel.com> <20231010200437.9794-2-ahmed.zaki@intel.com>
In-Reply-To: <20231010200437.9794-2-ahmed.zaki@intel.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 10 Oct 2023 16:40:41 -0400
Message-ID: <CAF=yD-+=3=MqqsHESPsgD0yCQSCA9qBe1mB1OVhSYuB_GhZK6g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, corbet@lwn.net, 
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org, mkubecek@suse.cz, 
	linux-doc@vger.kernel.org, Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 4:05=E2=80=AFPM Ahmed Zaki <ahmed.zaki@intel.com> w=
rote:
>
> Symmetric RSS hash functions are beneficial in applications that monitor
> both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
> Getting all traffic of the same flow on the same RX queue results in
> higher CPU cache efficiency.
>
> A NIC that supports "symmetric-xor" can achieve this RSS hash symmetry
> by XORing the source and destination fields and pass the values to the
> RSS hash algorithm.
>
> Only fields that has counterparts in the other direction can be
> accepted; IP src/dst and L4 src/dst ports.
>
> The user may request RSS hash symmetry for a specific flow type, via:
>
>     # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric-xor
>
> or turn symmetry off (asymmetric) by:
>
>     # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  Documentation/networking/scaling.rst |  6 ++++++
>  include/uapi/linux/ethtool.h         | 17 +++++++++--------
>  net/ethtool/ioctl.c                  | 11 +++++++++++
>  3 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/networking/scaling.rst b/Documentation/network=
ing/scaling.rst
> index 92c9fb46d6a2..64f3d7566407 100644
> --- a/Documentation/networking/scaling.rst
> +++ b/Documentation/networking/scaling.rst
> @@ -44,6 +44,12 @@ by masking out the low order seven bits of the compute=
d hash for the
>  packet (usually a Toeplitz hash), taking this number as a key into the
>  indirection table and reading the corresponding value.
>
> +Some NICs support symmetric RSS hashing where, if the IP (source address=
,
> +destination address) and TCP/UDP (source port, destination port) tuples
> +are swapped, the computed hash is the same. This is beneficial in some
> +applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and need
> +both directions of the flow to land on the same Rx queue (and CPU).
> +

Maybe add a short ethtool example?

>  Some advanced NICs allow steering packets to queues based on
>  programmable filters. For example, webserver bound TCP port 80 packets
>  can be directed to their own receive queue. Such =E2=80=9Cn-tuple=E2=80=
=9D filters can
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index f7fba0dc87e5..b9ee667ad7e5 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2018,14 +2018,15 @@ static inline int ethtool_validate_duplex(__u8 du=
plex)
>  #define        FLOW_RSS        0x20000000
>
>  /* L3-L4 network traffic flow hash options */
> -#define        RXH_L2DA        (1 << 1)
> -#define        RXH_VLAN        (1 << 2)
> -#define        RXH_L3_PROTO    (1 << 3)
> -#define        RXH_IP_SRC      (1 << 4)
> -#define        RXH_IP_DST      (1 << 5)
> -#define        RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP/S=
CTP */
> -#define        RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP/S=
CTP */
> -#define        RXH_DISCARD     (1 << 31)
> +#define        RXH_L2DA                (1 << 1)
> +#define        RXH_VLAN                (1 << 2)
> +#define        RXH_L3_PROTO            (1 << 3)
> +#define        RXH_IP_SRC              (1 << 4)
> +#define        RXH_IP_DST              (1 << 5)
> +#define        RXH_L4_B_0_1            (1 << 6) /* src port in case of T=
CP/UDP/SCTP */
> +#define        RXH_L4_B_2_3            (1 << 7) /* dst port in case of T=
CP/UDP/SCTP */
> +#define        RXH_SYMMETRIC_XOR       (1 << 30)
> +#define        RXH_DISCARD             (1 << 31)

Are these indentation changes intentional?


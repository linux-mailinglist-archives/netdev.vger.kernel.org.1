Return-Path: <netdev+bounces-233105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC3C0C573
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7083B3B3F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AD92E7F2C;
	Mon, 27 Oct 2025 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9ywkqFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D4254B1F
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554357; cv=none; b=rlTTKdjbx3PI7Erk1vGetDuC4QMbKXIOrC6c82ae0NRNE1cH+0RjlxVhwfV5RKduQyh4Ah1IVfHtS25y39rwXA7aKyxCo0Sbi3vxYdwoE5Hfi90n8id8em04wHL5w2tcMWH8sk96t2Fhcfq1yjSMGXXODp/xtcH3VThAzVv21t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554357; c=relaxed/simple;
	bh=GLiLZMSjaCs2xW4XMjRxYexu0HaP4oAlngKEAgwbMhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfyM9WwdQweRMigqVjFRsV6g+e+h4souFbI79b6xBuEQJv56hmSTDamie20PvR/iK0YOBLIaezm5dWDgbyJ+epB/Xuhn0H/71vz+3QZT/9VKxIOTMVPpnccBBmIyttCUV/kBjaWf/gry+wBEMskea5yulpJWCdS15tJweaJ2MCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9ywkqFw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4eceef055fbso26155131cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 01:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761554355; x=1762159155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLiLZMSjaCs2xW4XMjRxYexu0HaP4oAlngKEAgwbMhk=;
        b=B9ywkqFwO+RvAMqtAuQRCWRC/ig1/SNrIKKZgkHk+RLAkQS/4zYOxjhFMv9hhsEq4+
         BZYng2DqG98nG/u5NEjEZwrKQRtW45N6Aaokl5Zfw6gvQb2ohTg5uitlUV1R68poVc/P
         ZOHEgp8AAkpELr7rvSHwB/jueHQZ3GfcC/XD+g1WNcZXdCfQuRKaHO1Om/cr/EYr4UHn
         06p2z1l8RfImH3Tk+Sv4cTUeSJwv73CbCGq06ucoDI6Si7GksyDrjiVBSec761vD0Mzc
         BGKjqeOXhdXdYmE1v7zrjHEztKN4HV1Ia1nAX8Hh80H66se4igoBWnCWiisZkjHJYNAO
         jxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554355; x=1762159155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLiLZMSjaCs2xW4XMjRxYexu0HaP4oAlngKEAgwbMhk=;
        b=uXsfJV5cbSWz+X77zQW9jg8Ucf1akwRyw8nSlyxCfLuIfyTHHkTMLpX78Z2F3O/9CQ
         QTlGn2cpFz3jLbRwOoaB641veox+TdryhVLGJ0SIdGzJJh0AM4igae8YFTuCiFH8DJmp
         PNcRSFCP5P8ODfzPwFjhSlfFmLfdauxZllnyJ3Ns+/O4tW3osa3e7cdO25Nwa/vH3mPE
         i5JNaapkDPTTCcAuFqd+h6POqdNnoaXlgtBeK/xbzqV+KqhOX/RtfjmC2Ybnv/BU0dFW
         CCuVViyxnZkggr8opVJPU/yU9BFEaCbuaGk7A9CzeHb7yGcvYrp38Z3VCGp5ajTZcYFk
         PW+Q==
X-Gm-Message-State: AOJu0YzPRCfQyquUDrr109J+8mOIoWR30eGQzCHncp0XmVTu2MYMktt0
	gwOo1zDt/A1fyRdOAjWvLxb/O/MDsopHHRmSW+kn3Xvv4W1UNtghwPkGCxLOtoDWlD4cPgyT4i9
	7pZztA9BvjT96Cy6CaeRBBU4rRbb+1whzEwT+AzWm
X-Gm-Gg: ASbGncs/gFYx1VeDAMdHq8vcrT3nOaJZEhse0Hw8E0ERLZwoux6zZIVhhWJ1xdz7ygo
	TpmQh7HO/wIarG5pWf7l9ulsyX4z4u/P4GBO43tIKmYDA6CeJOUiWvRP+eg4C59zdfj+Pi6TDFc
	GEkZubvi14g1aGUzdRm8DHPNeWYZ+rjWD4tc7Zp0Kl03SBCZYko89Oy3E1GnnOJ7FTuM9LbG2M8
	SjNfJIFtVXi0U8yZwVd5JI9YtB4sIoDJmpURREtLxW8FDTyJLDDVkvEVDrrDRzf52vaHIc=
X-Google-Smtp-Source: AGHT+IGSAALqOIqQPqdQW5kpcKbc87z25QrKaKOBki5wfjcgLuf0TR4cPnmEu6tnthtNf4Gm3b8KYiJdEnllG4ytex0=
X-Received: by 2002:ac8:5708:0:b0:4e8:8ed6:9be3 with SMTP id
 d75a77b69052e-4e89d335819mr503244081cf.52.1761554354749; Mon, 27 Oct 2025
 01:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027082232.232571-1-idosch@nvidia.com> <20251027082232.232571-3-idosch@nvidia.com>
In-Reply-To: <20251027082232.232571-3-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Oct 2025 01:39:03 -0700
X-Gm-Features: AWmQ_blIpYAZ4Gelqj9PP6PEcpBOGCL9M9g_33zQNNsiCwQqG81g9EEb6QQWJiU
Message-ID: <CANn89iK-YDrmLdJKANDkb6WVSZdiPOYf3e18Hzx6xBk8cAgeUA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] ipv6: icmp: Add RFC 5837 support
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, petrm@nvidia.com, 
	willemb@google.com, daniel@iogearbox.net, fw@strlen.de, 
	ishaangandhi@gmail.com, rbonica@juniper.net, tom@herbertland.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 1:24=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Add the ability to append the incoming IP interface information to
> ICMPv6 error messages in accordance with RFC 5837 and RFC 4884. This is
> required for more meaningful traceroute results in unnumbered networks.
>
> The feature is disabled by default and controlled via a new sysctl
> ("net.ipv6.icmp.errors_extension_mask") which accepts a bitmask of ICMP
> extensions to append to ICMP error messages. Currently, only a single
> value is supported, but the interface and the implementation should be
> able to support more extensions, if needed.
>
> Clone the skb and copy the relevant data portions before modifying the
> skb as the caller of icmp6_send() still owns the skb after the function
> returns. This should be fine since by default ICMP error messages are
> rate limited to 1000 per second and no more than 1 per second per
> specific host.
>
> Trim or pad the packet to 128 bytes before appending the ICMP extension
> structure in order to be compatible with legacy applications that assume
> that the ICMP extension structure always starts at this offset (the
> minimum length specified by RFC 4884).
>
> Since commit 20e1954fe238 ("ipv6: RFC 4884 partial support for SIT/GRE
> tunnels") it is possible for icmp6_send() to be called with an skb that
> already contains ICMP extensions. This can happen when we receive an
> ICMPv4 message with extensions from a tunnel and translate it to an
> ICMPv6 message towards an IPv6 host in the overlay network. I could not
> find an RFC that supports this behavior, but it makes sense to not
> overwrite the original extensions that were appended to the packet.
> Therefore, avoid appending extensions if the length field in the
> provided ICMPv6 header is already filled.
>
> Export netdev_copy_name() using EXPORT_IPV6_MOD_GPL() to make it
> available to IPv6 when it is built as a module.
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---

Same small remark about consume_skb().

Reviewed-by: Eric Dumazet <edumazet@google.com>


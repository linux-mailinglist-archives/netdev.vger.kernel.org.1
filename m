Return-Path: <netdev+bounces-248639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B44D0C9A5
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 01:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65ABA3026B1B
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 00:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95042E40E;
	Sat, 10 Jan 2026 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF5/fIAP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2AE54B
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003876; cv=none; b=L9RgW0TQR0nfhygEzRBIEEVVJRCEeh6elpR2cxMuCEYRm3z7Hqys91abCh/BXupSTJYt0YEcbu/1Nz9uKhXFBqiTNPUstVVZGW8eykHEUTMXOUQ1bmYkTUDlHFPS5RL/ozwRMy/QNy5hSVH+z8EAeNRILy/oLoq0k6ASzHdi//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003876; c=relaxed/simple;
	bh=XszBXPJ18HkMpycCWMX0Y8i3Aoh/kyFsduWJiX9qSIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTM0zD74ipdRKCtpsGsNLMXxuTdEE1wq5tBEf2lYYQCDw20M2Q5dkqVzIe2Y3cYRbLLmoEqljPTD8PC2qelk/IXEDHeSH3hMQqyZDLXNheV5GiBNSDssD2PhXAtW4x9qVNOnpXuK/E7wS7b90VSb2XlxEB73gbEbeSVUYe42jdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF5/fIAP; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-646fe7f70e2so3386024d50.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 16:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768003874; x=1768608674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6N0A2c2LYMc0dJDgYzdUUiKfOdoal/WEyiilk+5HTkg=;
        b=WF5/fIAP4AEyO4f6KWSJP2rwaSy/sViblkfSeeU8EGHt4W8zcGu8GdInztygNBG+SI
         lFZMtf5mk92Bho0bl/kz0wrylefbq54djvfDKFetQZqFm4VltIFlMyuYZ3TYsee7EuPv
         cuFATTU+AojUbvwayi9w7OyNstSzzzIWEbhQr08urKNmtzyFQEASvw8VCOBtpjn1hEZ7
         /S6AXS4ADril+8pCuPrnQcp3DFjvjtLVBL9cCPyinaRd8F5C9kJqxbl7/LUxO4bKzb5y
         2VTvsnHADEUfrU8ytID59HZXZVXxMG6DT+qvAAEn0faaDEgjA/ym8ZI4sdu6WxDKie2G
         EoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768003874; x=1768608674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6N0A2c2LYMc0dJDgYzdUUiKfOdoal/WEyiilk+5HTkg=;
        b=vLuvXDUhRLePqhTCxE0sXtlMNF1RhpwbKeqvSNIk2twJWhYbcp2zSJnr6CkGmzayt4
         yIvEWFv3xx1Z9ME2tygn/ddDrl0fBnewzvID09RcXyQkExqzIRpk7dOqRXtADDdH9YZL
         NRRgeDSwR+8BEtHzLuvw9MlLS3Y2dRyJdZUrhjlyhc0MDeXzqm/EVnXzDYKmx3lMVy2+
         iemq2auQsmpozSt2Rh8xBy3Q0KF1egK2bLqJ8AbWCFrZjwfy+5mVsGd8mqkP8fHTK1fn
         sAUvOKQEhUGKa6Zu7IlAVJ6rVCUbpHCG/z3Ihhsa8ig5C7bFVcZFWR+zZaegXGmblwTm
         D1kw==
X-Forwarded-Encrypted: i=1; AJvYcCVVnv7WW8LPCOMW8Vouc97maUJ8STltK6RrnZQ4ffpQGfPdBgiisJZW3uSJIDXpXNVNcX63tmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGQcFCOoOXho2fDvQDFpXru2H+P/lkFPdDfmSWdK4AUA3QTAe
	6m+4Y4CreKF9uIReY+KyLU3FFhCH82Tx0eR9DzXBpMDb9uELjhbqvAOD
X-Gm-Gg: AY/fxX67nvawYhLDsvz9/8QeIsh9A3jFk9m+ZvJ4v7OSlRmhoV6Sx+oPSBV7DebvSaM
	FarEuGzC0JK9CgCAJ/evEro10k1sqRN3TTyG7tBP1UppRhWswyzV9m7pK+CqDYu5oS1W7+UwfdX
	dk1ADqTGjmgabTUVnB0Bbe1woD0Awf1Ke1rMN5laWvgwPOkc2KoItRJ5qIOV0IicMTsAxQq/jME
	GeBgllxQ+2Hvh7+6lP5rWcLZjAar65C6xIEu6A587c5i9oUKff5YiwcF5AhbuF6NaSo5F43pGIi
	ObpqVw2dCWBg+mrDc/HmiuIFrs54IMFpoAn/HHteKs+HSWr4+EVgV4t8kZBd48ueLuu/jcEc7br
	LbFRwEzkxmaX9ebI0daxKSG74DOnmyvawVGcmRWnUdCNaF7UU4C0zcuFUGfXQSBkHpWZVPiWNVe
	5mQzxpo4PLtPo97iSvScULfMeNnXWyNUXaKw==
X-Google-Smtp-Source: AGHT+IE5CW/VP1bFR/Dosae0XD0Rb9scRJI8ZCC2GQQ5cF/xpuuKEVGU70q9buii5G2BZNROzhlUqg==
X-Received: by 2002:a05:690e:1611:b0:644:7712:ed72 with SMTP id 956f58d0204a3-64716bd7b38mr8182868d50.43.1768003873903;
        Fri, 09 Jan 2026 16:11:13 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa553ac3sm46524707b3.5.2026.01.09.16.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 16:11:13 -0800 (PST)
Date: Fri, 9 Jan 2026 16:11:12 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>

On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> This series adds namespace support to vhost-vsock and loopback. It does
> not add namespaces to any of the other guest transports (virtio-vsock,
> hyperv, or vmci).
> 
> The current revision supports two modes: local and global. Local
> mode is complete isolation of namespaces, while global mode is complete
> sharing between namespaces of CIDs (the original behavior).
> 
> The mode is set using the parent namespace's
> /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> created. The mode of the current namespace can be queried by reading
> /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> has been created.
> 
> Modes are per-netns. This allows a system to configure namespaces
> independently (some may share CIDs, others are completely isolated).
> This also supports future possible mixed use cases, where there may be
> namespaces in global mode spinning up VMs while there are mixed mode
> namespaces that provide services to the VMs, but are not allowed to
> allocate from the global CID pool (this mode is not implemented in this
> series).

Stefano, would like me to resend this without the RFC tag, or should I
just leave as is for review? I don't have any planned changes at the
moment.

Best,
Bobby


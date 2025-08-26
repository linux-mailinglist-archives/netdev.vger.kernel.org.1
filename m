Return-Path: <netdev+bounces-216821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B7B354D7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538F9171B97
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2432D0C6C;
	Tue, 26 Aug 2025 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsmuFAYD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05326502BE
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191333; cv=none; b=GhybduNCqVh6+oE4zjpmRJt24HlFFSeBYFOp+R6zZGSYp36i0lKhnK3STalJSRrJnL1hGkdAmi9eX3fq2HHKhaiWrunq5FqDK5me8NMnDVKQouEalNdLgcNErsLcdhQTUxwjrPtKL18lV0uAQilAyRYa5r2zylPIKVoG1Vy9Ve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191333; c=relaxed/simple;
	bh=lfYDEmq/PJ3a1IV7rqEkbYnZYxrR/rNVv2UdEgAHyRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJkokEMd4qSdubYv2XU6AqSIhF0+uLco5TIfia0QcDDF98trd5Xor2LuQ2T/Sca1FFicVhC97FhT1cdCZsM8CLl/igCzyPVeBcWpJtxmra1s5wRRjXwV++SkueFeQ+XnAYtgujfeSFMt2HbBgPW9SI2903nsmvLAk1U2HP7bWoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsmuFAYD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756191330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q60KSVuyNOUDgOYXDvtWxnNnwoxcnqjIk3EQCjfaX0U=;
	b=XsmuFAYDbpTP5xdZ9sLcAlmm84QgrMPr54TecDwnNEUmno2HuVaJQHEQw5c2RUamy+5qUu
	RsDLxnoutj575WFKEQ/RoitgXQVofK2kZcaufUVKnK0D37BOtnlnD9/HvEFEDf6yt0wBDC
	B8VFMQGeObPeybMHMXfNVUL/LkrCV3o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-LTLM8eZWOFOeZkUdDolJcQ-1; Tue, 26 Aug 2025 02:55:28 -0400
X-MC-Unique: LTLM8eZWOFOeZkUdDolJcQ-1
X-Mimecast-MFC-AGG-ID: LTLM8eZWOFOeZkUdDolJcQ_1756191327
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0d221aso26023295e9.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756191327; x=1756796127;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q60KSVuyNOUDgOYXDvtWxnNnwoxcnqjIk3EQCjfaX0U=;
        b=RV7K8NCwWmH06yv0xomQZlaWxOMVy9o292Qkin1O7yNZBi4ljWQ48Ku4Qm1MAItIEB
         SsUfiMaWoOdIZ/JGu2nO+H2eNxNd4huTZd7CB+gyZtAU9BuRaud9gKvn1MKWBp8A892w
         4OYBSNZZw+VfCs2su7ZVNIU4nT+l6gc+pDY9nzHD+bYfiBEssfozRQTqjZBa2tBWWFp9
         Z7+6Nf39uTcCCmJNKX99TgfdJh+hrT2IUF/SbiIA+OjcTQ37DOVkfuaiNJ3UcXGlJ5tM
         zD+hcAUjqXR74VV3mjDZWzJfalUYO7oGG0Wu7sAiOvpOAAfhifxS0vGrrKs0v5re8HHX
         oWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPk+DW5GEDdBmAlLRfiGcVVXjKhJQUrJlEVoPKPp008ejPuY1dRedKNVhohT7b5JVAgvSNb7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhNnvIKqNanB8QMKmVLEaFYNoVFm5Sr9Oyf069Ic98s88HL1VF
	87vSj246Kuv8eMiIdhlPIVUzUGPMofIgN+klli+R00mhFyfaPIWKAjXfXnJ8yOl4K+oOwpIRPCI
	wmVgP42zyT9ukM6dfvbWAt9R6QMY7s6JrBDR855rfaH3QzItSMHxUCDSPIg==
X-Gm-Gg: ASbGnctjdwQNdQFOxXrBPsTw/ZZs7Z0MVx6danIT3ychiQgJvV0v7X9AdSZPp4dxL8m
	GYe0Q+seWKtDMKM79PaAuE7UeIE/vW0eIfrjaPn2iOZCuwZvN6l5QnE4rbYytrLueFFtkkwaVmK
	ET27hFze1YeSYNp3YCVxDLQ0Eeullau6vwO9IfVl6GeTQKeYOGJFwYmCTmHWppVsx7Yd0qoxQnr
	llEPiJpf6TqF2E646ITm3ToZMgjuFtmBXcQYfGy2Tht5iytIYld/WvbiiAgX589r9zemw0IG4dp
	Zqh4VNTnJ7b4Wp2y4WlAhqF+dWhk8umCKF7Ng3nPDAtK+fPl32tBFsbvU08+R9pQuYN0
X-Received: by 2002:a05:600c:1546:b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-45b517a0664mr126115925e9.12.1756191327466;
        Mon, 25 Aug 2025 23:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDI3qwfBcTEIfwvsnd/l72H+vatlsmpc7c/ZdgRSmE4QbIjhKLn2UZpi56KC0gXi9QrzwQDA==
X-Received: by 2002:a05:600c:1546:b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-45b517a0664mr126115755e9.12.1756191327119;
        Mon, 25 Aug 2025 23:55:27 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66b6985bsm9070115e9.2.2025.08.25.23.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:55:26 -0700 (PDT)
Date: Tue, 26 Aug 2025 08:55:25 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Paul Wayper <pwayper@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 paulway@redhat.com, jbainbri@redhat.com
Subject: Re: [PATCH iproute2] ss: Don't pad the last (enabled) column
Message-ID: <20250826085525.748ed6b3@elisabeth>
In-Reply-To: <20250826002237.19995-1-paulway@redhat.com>
References: <20250826002237.19995-1-paulway@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 10:22:37 +1000
Paul Wayper <pwayper@redhat.com> wrote:

> ss will emit spaces on the right hand side of a left-justified, enabled
> column even if it's the last column.  In situations where one or more
> lines are very long - e.g. because of a large PROCESS field value - this
> causes a lot of excess output.
> 
> Firstly, calculate the last enabled column.  Then use this in the check
> for whether to emit trailing spaces on the last column.
> 
> Also name the 'EXT' column as 'Details' and mark it as disabled by
> default, enabled when the -e or --extended options are supplied.
> 
> Fixes: 59f46b7b5be86 ("ss: Introduce columns lightweight abstraction")
> Signed-off-by: Paul Wayper <paulway@redhat.com>

Thanks for the new version (this should have "v2" in the subject line).
I'll have a look and test in a bit.

-- 
Stefano



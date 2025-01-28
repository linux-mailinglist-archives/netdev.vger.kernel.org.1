Return-Path: <netdev+bounces-161333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1151A20B48
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3F5164E43
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D4C1A7249;
	Tue, 28 Jan 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xxn69lTI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CAD1A08A6
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070748; cv=none; b=rJgAxHc5pTh0kVjUFEOLh6Kb55NTNdVQNPCwwJdbENItHSllOarxiTivBPpi6/2zmXyQx5PnO6bNj5wMh/8UWT2B+IO610mGIv+yhalRxaUfe4J83vQaZ+2hDxzcAcvwhMha4eBjL2X4pd7WyjYVYEr2GDLtd1sl9UEpKYyR+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070748; c=relaxed/simple;
	bh=xXmQSPCOE/q0+j4J49P0P6RP4ItkqYK84im10n0cc6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRciSW3GdeJAf7aLp90hEWftT87ifWHM/ZH+MkUX9XZ4HLiWhn8+mEEJ/olurHtbwXV6ziNLfY/Z4M/jwWdoXUrKPCJRLQ1VtGkcgQwu7hKLgDQrgeW1d8zz85h4VKSS55+6kaZf4wJREo2wEOaPlOV5pbUlNM7xfCoYiLL3WNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xxn69lTI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738070745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5n485xg/tbqT5XAK7sBKs4ZveDcXWXBDinLLkF7KVwU=;
	b=Xxn69lTI1TXbsaxWXBCOxyQl3gNjscRJof4JD0LHnkudGBcJ4pwkGI+ZQ5sifH2WkR3t4S
	+e8mGvv5fb3HlFsCJ0H94gzx50Qxkgp4Zh+XnuEXqi6B3yQkm+f9IHAg2W1D/5JRHRl7Q/
	F56gneamqjqoaK2TM+3cKbrBtSOvM2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-5qJhgs60M_yxE169LOjVZA-1; Tue, 28 Jan 2025 08:25:43 -0500
X-MC-Unique: 5qJhgs60M_yxE169LOjVZA-1
X-Mimecast-MFC-AGG-ID: 5qJhgs60M_yxE169LOjVZA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385ded5e92aso2297659f8f.3
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 05:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738070742; x=1738675542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n485xg/tbqT5XAK7sBKs4ZveDcXWXBDinLLkF7KVwU=;
        b=JDut3K2BCSQMfgPTEc3lFq/M5arYTJbs9RXUknHshJ6jQKLP23yKq5HkZ32ozcpBAW
         QhwSZ874HEmu29PJUWL14mM8dSZ49lFJYDLRxmPBcwMB446pb+dx117TewUkh2yRbdOL
         Wp63rTmtNj+1kUCko6bgDOUZcdMfX15dRUMwD8HP+qcVi5ilky8GvpT88r5mKoQyXSzY
         3S52HI/mBPXL+3GOJdg/gpPU4ynvBvt9zstvMLk67I7C55KFf3gHfZFxwv4IJnJGSIBz
         IzbgwX4j0q1v9CcHJQ5+9ztAPA23XvP2ZaRgCbtqmPTiIJ6/7IRrRP4Q7R+YPCLwlrJM
         ZcAw==
X-Forwarded-Encrypted: i=1; AJvYcCVzj5/1P64Mnhgw1QvNWMvC1TFlORnK7ObO2CWfSSlZidcyU/oxB4J1lL8bq+nXgGKFTOGA3xI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5j0Q7F3Za+0HeGPP4fVa/Mzak8YYIxf93aTO1VqNq5vg+9F9v
	P0Eva2a//Wanh970H9gdyUI56b0/YzhlJnkhMO6K0ubgT0cXQr15KunFaLtNgU09K+WBEvgDrhE
	HvUrFCKvAumzWITMURd7vn6qrNQRG805ACHNwaOy5g1hzykVY6NxS/Q==
X-Gm-Gg: ASbGnct6bheC97fvgsyQmLyoxxlO3ijyTpt+vMhdhqmOAnVNjTF4C5stHkGR5+CIDGu
	G4/4au2OzBgtleE+HPT7FRsHsMRyaYiSCaBVJOEjOsM61hR/dhfxqFQuWcYWVOSXdZOpat11SK2
	egLDks+nSH+cWeYT69bGPRTYNLQigKpDkQbiuQvwc9syDO2pZ1gJQOif08i/ehPB7AiOCxKHqxR
	4ZBL4SokdJoQPbdjwHsSZdOW2THvExxtd6D4axgCU+oxtTW4TPoR6puzCMHZesizZeFmZFCDJ7m
	SNO0/yQO
X-Received: by 2002:a05:6000:2a3:b0:38a:888c:679c with SMTP id ffacd0b85a97d-38bf59e21d6mr38958519f8f.42.1738070742311;
        Tue, 28 Jan 2025 05:25:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI1ckDOGbH2Z/XjBCGkfB1aD+MOGF0AFxjkiOnY1C6dGrybeYxKyU2FFmlM6TSPD89uDvoSA==
X-Received: by 2002:a05:6000:2a3:b0:38a:888c:679c with SMTP id ffacd0b85a97d-38bf59e21d6mr38958494f8f.42.1738070741914;
        Tue, 28 Jan 2025 05:25:41 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507dc9sm172083215e9.19.2025.01.28.05.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 05:25:41 -0800 (PST)
Date: Tue, 28 Jan 2025 14:25:39 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net v3 0/6] vsock: Transport reassignment and error
 handling issues
Message-ID: <xqtxs5auazrrfqess6fewfjt3vc6t7jato3if3thnjtkwr5g34@anly3yn64yxo>
References: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>

On Tue, Jan 28, 2025 at 02:15:26PM +0100, Michal Luczaj wrote:
>Series deals with two issues:
>- socket reference count imbalance due to an unforgiving transport release
>  (triggered by transport reassignment);
>- unintentional API feature, a failing connect() making the socket
>  impossible to use for any subsequent connect() attempts.
>
>Luigi, I took the opportunity to comment vsock_bind() (patch 3/6), and I've
>kept your Reviewed-by. Is this okay?
Hi Michal,

Yes, absolutely! Thanks for adding the comment :)

Cheers,
Luigi

>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Changes in v3:
>- Rebase
>- Comment vsock_bind() (Luigi)
>- Collect Reviewed-by (Stefano, Luigi)
>- Link to v2: https://lore.kernel.org/r/20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co
>
>Changes in v2:
>- Introduce vsock_connect_fd(), simplify the tests, stick to SOCK_STREAM,
>  collect Reviewed-by (Stefano)
>- Link to v1: https://lore.kernel.org/r/20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co
>
>---
>Michal Luczaj (6):
>      vsock: Keep the binding until socket destruction
>      vsock: Allow retrying on connect() failure
>      vsock/test: Introduce vsock_bind()
>      vsock/test: Introduce vsock_connect_fd()
>      vsock/test: Add test for UAF due to socket unbinding
>      vsock/test: Add test for connect() retries
>
> net/vmw_vsock/af_vsock.c         |  13 ++++-
> tools/testing/vsock/util.c       |  88 +++++++++++-----------------
> tools/testing/vsock/util.h       |   2 +
> tools/testing/vsock/vsock_test.c | 122 ++++++++++++++++++++++++++++++++++-----
> 4 files changed, 153 insertions(+), 72 deletions(-)
>---
>base-commit: 9e6c4e6b605c1fa3e24f74ee0b641e95f090188a
>change-id: 20250116-vsock-transport-vs-autobind-2da49f1d5a0a
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>



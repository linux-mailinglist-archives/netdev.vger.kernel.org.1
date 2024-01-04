Return-Path: <netdev+bounces-61681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5D8249CF
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 21:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E4D1C22A54
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 20:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30BB1E523;
	Thu,  4 Jan 2024 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDNpwU21"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B72C681;
	Thu,  4 Jan 2024 20:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A531BC433C8;
	Thu,  4 Jan 2024 20:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704401576;
	bh=UeDLFPp+VrbxKGWywntQSZVNGTOQs09CcRcFafJG0IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDNpwU218VdVH3edCbpysDNbCm9m6ohm5gbiNbwa87RS2DpvVRlpf//dhb0Rtw9di
	 aT8UOxdjMOsnPiENb5lm23TI93nZMo4ee4vDObX/ihGbksr01FKJlFPJdmQMQGgSeb
	 dAOuOtDfu9BWfB+V8vCc2WIg4vlJMGhN0xiN0hASyCGog5oHvIcVhRO6fwR8KBCSuC
	 2HboKMRcDKtB2YreBd5ICadRcawPE2O6i6EVmW1F5NDp3enO43fGY09gA/YyjrJSgB
	 7ixeF1Pph/2N57kx8VBnG5H9rx3dw2QUg1o37duUUuVH/nNjLdUV3rs/6MnK9Poh5H
	 +h80VrTf2Kqmw==
Date: Thu, 4 Jan 2024 20:52:51 +0000
From: Simon Horman <horms@kernel.org>
To: Jonas =?utf-8?Q?Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Remove superfluous call to
 hci_conn_check_pending()
Message-ID: <20240104205251.GO31813@kernel.org>
References: <20240102185933.64179-1-verdre@v0yd.nl>
 <20240102185933.64179-2-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102185933.64179-2-verdre@v0yd.nl>

On Tue, Jan 02, 2024 at 07:59:28PM +0100, Jonas Dreßler wrote:
> The "pending connections" feature was originally introduced with commit
> 4c67bc74f016b0d360b8573e18969c0ff7926974 and
> 6bd57416127e92d35e6798925502c84e14a3a966 to handle controllers supporting
> only a single connection request at a time. Later things were extended to
> also cancel ongoing inquiries on connect() with commit
> 89e65975fea5c25706e8cc3a89f9f97b20fc45ad.
> 
> With commit a9de9248064bfc8eb0a183a6a951a4e7b5ca10a4,
> hci_conn_check_pending() was introduced as a helper to consolidate a few
> places where we check for pending connections (indicated by the
> BT_CONNECT2 flag) and then try to connect.
> 
> This refactoring commit also snuck in two more calls to
> hci_conn_check_pending():
> 
> - One is in the failure callback of hci_cs_inquiry(), this one probably
> makes sense: If we send an "HCI Inquiry" command and then immediately
> after a "Create Connection" command, the "Create Connection" command might
> fail before the "HCI Inquiry" command, and then we want to retry the
> "Create Connection" on failure of the "HCI Inquiry".
> 
> - The other added call to hci_conn_check_pending() is in the event handler
> for the "Remote Name" event, this seems unrelated and is possibly a
> copy-paste error, so remove that one.
> 
> Fixes: a9de9248064bfc8eb0a183a6a951a4e7b5ca10a4
> Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>

Nit: a correct format for the fixes tag is

Fixes: a9de9248064b ("[Bluetooth] Switch from OGF+OCF to using only opcodes")

Likewise, in the patch description, it is usual to cite patches
using a similar format.

e.g. introduced in commit
     4c67bc74f016 ("[Bluetooth] Support concurrent connect requests")

Note it is usual to use a hash of at least 12 characters
(and not much more than that).

...


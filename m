Return-Path: <netdev+bounces-152276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3499F3555
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208AA1633EE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1214D6EB;
	Mon, 16 Dec 2024 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkxwaAjn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C94126C0D;
	Mon, 16 Dec 2024 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365228; cv=none; b=K5LTKmykI5ul1ww3l6gsnWwwX8gZy2X/3zfWdIlkGfaKpnfYSBT2JmUPKW3qfTVVOgd/oFma21a35UCoeu/wNfXAnccEYCOhVYdrByG5kixeGG8bxJuajEdZxJmOkWrWXUF3xbDwQ86FiK8CopGETxq5FENQFR5hXt1DQnmuClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365228; c=relaxed/simple;
	bh=AHmX+az1yBZgu+kXFSWMbnvN1hXg+iXAHrgsckuq8rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt8I0tMouiuZQ4LDA1rddwVIpOKdboJdFaFyjrT3ONxASX1bKTZXgOdy9NW4xg333TeCRbgIwBKyxft3ONBPAsfbV3Dj2yFrM+a9Y4A0YvbRzFMIQKgsEhZECTkiULB5dAW/jcf+xxTpGHAUyXRt/8afcDMndaIjDzpj5huPde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkxwaAjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD660C4CED0;
	Mon, 16 Dec 2024 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734365227;
	bh=AHmX+az1yBZgu+kXFSWMbnvN1hXg+iXAHrgsckuq8rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkxwaAjnDiQYI+7SmktHriCvndTnp/o5KApG30s2gWJ9cpWgC7GNozqjn+i01IrPU
	 55pD++VjZ+dLT7daCw95owhWWGoxWfrvowD58fZCdXvPmZAHCRH9x+i0F5rSdVhjPp
	 ku4RqofbuLPEZ/uohFG0AHDIUOyPbyyvk4cminoqARF8YusW4CP5nTcnFiTdsmb3Wi
	 UGc42lZeOmRMALybz8ywCp+cfTWtDGFOEzMLv8nRGFVlW8HaJZuX0bYlYswCUZRQV8
	 HbvmnRboSudJc/EnnSHM6Re2GIsi4UVqY5hZh7iNLqXAubbEGCmf1JMevSFPqANH0A
	 TcRmwEk4L+pYg==
Date: Mon, 16 Dec 2024 16:07:03 +0000
From: Simon Horman <horms@kernel.org>
To: Gianfranco Trad <gianf.trad@gmail.com>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] qed: fix possible uninit pointer read in
 qed_mcp_nvm_info_populate()
Message-ID: <20241216160703.GE780307@kernel.org>
References: <20241215011733.351325-2-gianf.trad@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215011733.351325-2-gianf.trad@gmail.com>

On Sun, Dec 15, 2024 at 02:17:34AM +0100, Gianfranco Trad wrote:
> Coverity reports an uninit pointer read in qed_mcp_nvm_info_populate().
> If EOPNOTSUPP is returned from qed_mcp_bist_nvm_get_num_images() ensure
> nvm_info.num_images is set to 0 to avoid possible uninit assignment
> to p_hwfn->nvm_info.image_att later on in out label.
> 
> Closes: https://scan5.scan.coverity.com/#/project-view/63204/10063?selectedIssue=1636666
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> ---
> Notes:
>   - Changes in v2: set nvm_info.num_images to 0 before goto out.
>   - Link to v1: https://lore.kernel.org/all/20241211134041.65860-2-gianf.trad@gmail.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


